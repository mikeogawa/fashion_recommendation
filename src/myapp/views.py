from django.http import HttpResponse,FileResponse
from django.shortcuts import render
from django.core.files import File
from django.http.response import JsonResponse
import numpy as np
from .algorithm import maskMaxNodeChooser,model

# Create your views here.
def index_template(request):
    return render(request, "main/index.html")

def image_only(request):
    image_data = open("myapp/static/myapp/blackshirt.png", "rb")
    # return HttpResponse(image_data, content_type="image/jpeg")
    # return HttpResponse(File(open(image_data, 'rb')), content_type="image/jpeg")
    return FileResponse(image_data)


def image(request,mode,number):
    if mode == 0:
        image_data = open("myapp/static/myapp/{}.png".format(number), "rb")
    else:
        image_data = open("myapp/static/myapp/b{}.png".format(number), "rb")
    # return HttpResponse(image_data, content_type="image/jpeg")
    # return HttpResponse(File(open(image_data, 'rb')), content_type="image/jpeg")
    return FileResponse(image_data)

def image2(request,number):
    image_data = open("myapp/static/myapp/{}.png".format(number), "rb")
    return FileResponse(image_data)

def nn(request,number):
    # number==0 is shirt
    i_list=request.GET.get("params").split(",")
    state = np.array([float(i) for i in i_list])
    i_list=request.GET.get("masks",None)
    if i_list:
        i_list = i_list.split(",")
    mask = np.array([float(i) for i in i_list]) if i_list else np.ones((6,))


    idx = maskMaxNodeChooser(model(state[None,...]),mask)
    print(idx)
    idx = int(idx)
    return JsonResponse({"idx":"{}".format(idx),"image":"black","title":"Puma"})
