import gevent.monkey
gevent.monkey.patch_all(thread=False, select=False)

import grequests as asyncreq
import requests


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


if __name__ == '__main__':
    # save_message("hi from popular kyle", 2, 1)
    save_message_async("what", 2, 1)
