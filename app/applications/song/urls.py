from django.urls import path
from rest_framework.routers import DefaultRouter
from . import views

router = DefaultRouter()
router.register('', views.SongViewSet)

urlpatterns = [
    path('album/', views.AlbumViewSet.as_view()),
]

urlpatterns += router.urls
