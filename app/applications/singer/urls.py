from django.urls import path
from . import views

urlpatterns = [
    path('', views.SingerAPIView.as_view()),
]
