## Auth

### Register

url: root/testapp/signup

Currently this only works for web login form.
I'm still trying to figure out how to login with the mobile form.

### Login

url: root/testapp/login

Same as above

### Logout

url: root/testapp/logout

Same as above


## Messaging

### Save Message

url: root/testapp/message-save
method: POST
data:
  - msg_content: str
  - sender_id: int
  - receiver_id: int

### Load Message

url: root/testapp/message-load?sender_id=[int]&receiver_id=[int]
method: GET
parameters:
  - sender_id: int
  - receiver_id: int

### Load Chatlist

url: root/testapp/chatlist-load
method: GET
parameters:
  - user_id: int
