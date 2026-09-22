FROM ubuntu:20.04

# Evitar preguntas interactivas durante la instalación con apt-get
ENV DEBIAN_FRONTEND=noninteractive

# 1. Habilitar arquitectura i386 e instalar librerías base de 64 y 32 bits + tipografías
RUN dpkg --add-architecture i386 && \
    apt-get update && apt-get install -y \
    build-essential \
    x11-apps \
    libxext6 \
    libxrender1 \
    libxtst6 \
    libxi6 \
    libglib2.0-0 \
    libgl1-mesa-glx \
    libgl1-mesa-dri \
    libpng16-16 \
    libice6 \
    libsm6 \
    fontconfig \
    locales \
    wget \
    udev \
    usbutils \
    fonts-dejavu \
    fonts-freefont-ttf \
    xfonts-base \
    xfonts-75dpi \
    xfonts-100dpi \
    libxft2:i386 \
    libxext6:i386 \
    libncurses5:i386 \
    libstdc++6:i386 \
    && rm -rf /var/lib/apt/lists/*

# 2. Descargar y extraer manualmente libpng12 (amd64 e i386) requeridas por Quartus/ModelSim
RUN mkdir -p /tmp/libpng_amd64 /tmp/libpng_i386 && \
    wget -q http://mirrors.kernel.org/ubuntu/pool/main/libp/libpng/libpng12-0_1.2.54-1ubuntu1_amd64.deb -O /tmp/libpng_amd64.deb && \
    dpkg-deb -x /tmp/libpng_amd64.deb /tmp/libpng_amd64 && \
    cp /tmp/libpng_amd64/lib/x86_64-linux-gnu/libpng12.so.0* /lib/x86_64-linux-gnu/ && \
    wget -q http://mirrors.kernel.org/ubuntu/pool/main/libp/libpng/libpng12-0_1.2.54-1ubuntu1_i386.deb -O /tmp/libpng_i386.deb && \
    dpkg-deb -x /tmp/libpng_i386.deb /tmp/libpng_i386 && \
    cp /tmp/libpng_i386/lib/i386-linux-gnu/libpng12.so.0* /lib/i386-linux-gnu/ && \
    ldconfig && \
    rm -rf /tmp/libpng*

# 3. Configurar locales a UTF-8
RUN locale-gen en_US.UTF-8
ENV LANG=en_US.UTF-8 \
    LANGUAGE=en_US:en \
    LC_ALL=en_US.UTF-8

# 4. Solución para el renderizado en blanco de la interfaz gráfica Qt/X11
ENV QT_X11_NO_MITSHM=1 \
    LIBGL_ALWAYS_SOFTWARE=1

# 5. Configuración de variables de entorno para Intel Quartus Prime 18.1
ENV QUARTUS_ROOTDIR=/intelFPGA_lite/18.1/quartus
ENV PATH=$PATH:/intelFPGA_lite/18.1/quartus/bin:/intelFPGA_lite/18.1/modelsim_ase/bin

WORKDIR /workspace

CMD ["/bin/bash"]
