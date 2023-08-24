from rest_framework import serializers

from applications.singer.serializers import SingerSerializer
from applications.song.models import Song, Album


class AlbumSerializer(serializers.ModelSerializer):
    class Meta:
        model = Album
        fields = '__all__'


class SongSerializer(serializers.ModelSerializer):
    class Meta:
        model = Song
        exclude = ('singer',)

    def to_representation(self, instance):
        rep = super().to_representation(instance)
        album = AlbumSerializer(instance.album, many=False).data
        album.popitem('singer')
        singers = SingerSerializer(instance.singer, many=True).data
        rep['album'] = album
        rep['singers'] = [dict_['name'] for dict_ in singers]
        return rep
