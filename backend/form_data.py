from fastapi import APIRouter,HTTPException,status
import asyncio
from typing import List
import firebase_admin
from firebase_admin import credentials,firestore
from pydantic import BaseModel
from . import deploy
cred = credentials.Certificate('hackathon-9f5f7-firebase-adminsdk-1vfic-eb2298f178.json')
firebase_admin.initialize_app(cred)

class Form_data(BaseModel):
    review:str

clubs={}

class session_data(BaseModel):
    club_id:str
    session_id:str
    review_id:str

class session(BaseModel):
    club_id:str
    session_id:str

router=APIRouter()

form_data_queue = asyncio.Queue()  

db=firestore.client()

@router.post("/submit_form")
async def submit_form(session:session_data):
        review=db.collection("clubs").document(session.club_id).collection("sessions").document(session.session_id).collection("reviews").document(session.review_id)
        doc=review.get()
        field=doc.to_dict().get("review")
        tags=deploy.predict(field)
        if session.club_id not in clubs:
             clubs[session.club_id]={}

        if session.session_id not in clubs[session.club_id]:
            clubs[session.club_id][session.session_id] = {'counter': 0}

            clubs[session.club_id][session.session_id]['counter'] += 1

   
        for sublist in tags:
            tag_name = sublist[0]
            tag_value = sublist[1]
            clubs[session.club_id][session.session_id].setdefault(tag_name, 0)
            if tag_value>0.1:
                 clubs[session.club_id][session.session_id][sublist[0]]=clubs[session.club_id][session.session_id][sublist[0]]+1
        

        update(clubs[session.club_id][session.session_id],session)
        return clubs[session.club_id][session.session_id]

    

@router.post("/stop")
async def toggle_form_submission(session:session):
    stop={"state":2}
    db.collection("clubs").document(session.club_id).collection("sessions").document(session.session_id).set(stop,merge=True)

def update(result:dict,session:session_data):
    try:
        doc=db.collection("clubs").document(session.club_id).collection("sessions").document(session.session_id)
        doc.set(result,merge=True)

    except Exception as e:
         raise HTTPException(status_code=status.HTTP_500_INTERNAL_SERVER_ERROR,detail=f"Error:{str(e)}")
