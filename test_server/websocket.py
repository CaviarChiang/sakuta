import asyncio
import websockets

async def hello(websocket, path):
    while True:
        try:
            print("found")
            name = await websocket.recv()
            print(f"< {name}")
            greeting = f"Hello {name}!"
            await websocket.send(greeting)
        except:
            print('connection lost')
            break

start_server = websockets.serve(hello, 'localhost', 5000)
print('Server started')
asyncio.get_event_loop().run_until_complete(start_server)
asyncio.get_event_loop().run_forever()