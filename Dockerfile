# Pull base image.
FROM jlesage/baseimage-gui:debian-10

# Install xterm.
RUN add-pkg xterm sudo wget curl sed fuse

RUN mkdir -p /usr/share/cura
# RUN mkdir /config # already exists
RUN mkdir /storage
RUN mkdir /output
RUN chmod 777 /output

# To upgrade, change this link here and rebuild the image. This can probably be tweaked to always pull latest.
# RUN wget -O /usr/share/cura/Ultimaker_Cura.AppImage https://software.ultimaker.com/cura/Ultimaker_Cura-4.6.1.AppImage
RUN wget -O /usr/share/cura/Ultimaker_Cura.AppImage https://storage.googleapis.com/software.ultimaker.com/cura/Ultimaker_Cura-4.12.0.AppImage
RUN chmod a+x /usr/share/cura/Ultimaker_Cura.AppImage

# Copy the start script.
COPY startapp.sh /startapp.sh

# Define mountable directories.
VOLUME ["/config"]
VOLUME ["/storage"]
VOLUME ["/output"]

# Metadata.
LABEL \
      org.label-schema.name="cura3d" \
      org.label-schema.description="Docker container for Cura3D" \
      org.label-schema.version="unknown" \
      org.label-schema.vcs-url="https://github.com/8layer8/docker-cura" \
      org.label-schema.schema-version="1.0"
      
# Set the name of the application.
ENV APP_NAME="Cura3D"

# Testing:
# docker rm docker-cura-test
# docker rmi docker-cura
# docker build -t docker-cura .
# docker images
# docker run --rm -p 5805:5800 -name docker-cura-test docker-cura
