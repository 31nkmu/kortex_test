from rest_framework.generics import CreateAPIView
from rest_framework.viewsets import ModelViewSet

from applications.song.models import Song, Album
from applications.song.serializers import SongSerializer, AlbumSerializer


class SongViewSet(ModelViewSet):
    queryset = Song.objects.select_related('album', 'album__singer')
    serializer_class = SongSerializer


class AlbumViewSet(CreateAPIView):
    queryset = Album.objects.select_related('singer')
    serializer_class = AlbumSerializer
