from rest_framework.serializers import ModelSerializer  # type: ignore
from base.models import Room
class RoomSerializer(ModelSerializer):
    class Meta:
        model = Room
        fields = '__all__'
