import os

from django.core.mail import send_mail
from config.celery import app


@app.task
def send_confirm_link(email, confirm_code):
    full_link = f'http://{os.environ.get("HOST")}:{os.environ.get("PORT")}/api/v1/order/confirm/{confirm_code}/'
    send_mail(
        'Ссылка для подтверждение заказа',
        full_link,
        os.environ.get("EMAIL_HOST_USER"),
        [email]
    )
