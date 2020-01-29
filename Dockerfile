FROM python:3.6

# Install.
RUN apt-get update && apt-get install -y --no-install-recommends \
        tzdata \
        python3-setuptools \
        python3-pip \
        python3-dev \
        python3-venv \
        git \
        && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*


RUN mkdir /modules
WORKDIR /modules
RUN git clone https://github.com/ReNom-dev-team/ReNom.git
RUN git clone https://github.com/ReNom-dev-team/ReNomRL.git

RUN pip3 install numpy && \
    pip3 install django && \
    pip3 install gunicorn

# set default environment variables
ENV PYTHONUNBUFFERED 1
ENV LANG C.UTF-8
ENV LC_ALL C.UTF-8
ENV DEBIAN_FRONTEND=noninteractive

ENV PORT=8000

#RUN pip3 install pipenv
#RUN pipenv install --skip-lock --system --dev

WORKDIR /modules/ReNom
RUN pip3 install -r requirements.txt
RUN pip3 install -e .


WORKDIR /modules/ReNomRL
RUN pip3 install -e .



ADD src /src

WORKDIR /src

#CMD alias python="python3"
#CMD alias pip="pip3"
EXPOSE 8000
CMD gunicorn main.wsgi:application --bind 0.0.0.0:$PORT
