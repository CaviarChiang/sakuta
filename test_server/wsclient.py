import asyncio
import websockets
import json

async def hello():
    sender_id = input("What's your id? ")
    json_obj = {
        "user_id": sender_id,
    }
    json_string = json.dumps(json_obj)

    async with websockets.connect('ws://localhost:5000') as websocket:

        await websocket.send(json_string)
        if sender_id == "zhou":
            print("zhou!!")
            print(await websocket.recv())

        while True:
            receiver_id = input("What's your destination id? ")
            message = input("What's your message? ")

            json_obj = {
                "sender_id": sender_id,
                "receiver_id": receiver_id,
                "message": message,
            }
            json_string = json.dumps(json_obj)
            await websocket.send(json_string)
            print(f"> {json_string}")
            print(await websocket.recv())

asyncio.get_event_loop().run_until_complete(hello())