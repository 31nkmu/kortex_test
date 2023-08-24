from rest_framework import serializers

from applications.singer.models import Singer


class SingerSerializer(serializers.ModelSerializer):
    class Meta:
        model = Singer
        fields = ('name',)
