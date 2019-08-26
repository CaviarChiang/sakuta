import gevent.monkey
gevent.monkey.patch_all(thread=False, select=False)

import requests
import grequests as asyncreq
import asyncio
import aiohttp
import websockets
import json


connection_map = {}


def save_message(msg_content, sender_id, receiver_id):
    # url = "http://18.222.226.32/testapp/message-save"
    url = " http://127.0.0.1:8000/testapp/message-save"
    res = requests.post(url, data={
        "msg_content": msg_content,
        "sender_id": sender_id,
        "receiver_id": receiver_id,
    })
    print_response(res)


def print_response(response):
    print(res.status_code, res.reason)


def save_message_async(msg_content, sender_id, receiver_id):
    # url = "http://18.222.226.32/testapp/message-save"
    url = " http://127.0.0.1:8000/testapp/message-save"
    action_item = asyncreq.post(url, data={
        "msg_content": msg_content,
        "sender_id": sender_id,
        "receiver_id": receiver_id,
    }, hooks={'response': print_response})
    asyncreq.map([action_item])


async def hello(websocket, path):
    print("connection haahah")

    global connection_map

    # login
    client_id = parseJSON(await websocket.recv()).get('user_id')
    if client_id in connection_map:
        connection_map[client_id].append(websocket)
    else:
        connection_map[client_id] = [websocket]
    print("client " + client_id + " is logged in.")

    # relay msg
    while True:
        try:
            recv_obj = parseJSON(await websocket.recv())
            sender_id = client_id
            receiver_id = recv_obj.get('receiver_id')
            message = recv_obj.get('message')
            print("received message: " + message +
                  " from " + sender_id + " to " + receiver_id)
            # save_message(message, sender_id, receiver_id)
            save_message_async(message, sender_id, receiver_id)

            for conn in list(connection_map[receiver_id]):
                try:
                    await conn.send(message)
                    print(f'message relayed to {receiver_id} from {sender_id}')
                except:
                    connection_map[receiver_id].remove(conn)
                    print(f'bad connection removed')

        except:
            print('connection lost')
            break


def parseJSON(json_string):
    return json.loads(json_string)


start_server = websockets.serve(hello, '0.0.0.0', 5000)
print('Server started?')
asyncio.get_event_loop().run_until_complete(start_server)
asyncio.get_event_loop().run_forever()
