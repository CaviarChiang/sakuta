import asyncio
import websockets
import json

connection_map = {}

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
            print("received message: " + message + " from " + sender_id + " to " + receiver_id)

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
