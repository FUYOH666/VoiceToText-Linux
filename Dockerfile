# VoiceToText-Linux Docker Container
FROM ubuntu:22.04

# Set environment variables
ENV DEBIAN_FRONTEND=noninteractive
ENV LANG=C.UTF-8
ENV LC_ALL=C.UTF-8

# Install system dependencies
RUN apt-get update && apt-get install -y \
    build-essential \
    git \
    cmake \
    alsa-utils \
    pulseaudio-utils \
    xclip \
    libnotify-bin \
    wget \
    python3 \
    python3-pip \
    && rm -rf /var/lib/apt/lists/*

# Clone and build whisper.cpp
WORKDIR /app
RUN git clone https://github.com/ggerganov/whisper.cpp.git && \
    cd whisper.cpp && \
    make clean && \
    make -j$(nproc)

# Create models directory and download models
RUN mkdir -p /app/whisper.cpp/models && \
    cd /app/whisper.cpp/models && \
    # Download base model (small, for quick start)
    bash ../models/download-ggml-model.sh base && \
    # Download large-v3 for Russian (main recommendation)
    bash ../models/download-ggml-model.sh large-v3

# Copy our project files
COPY . /app/voicetotext-linux/

# Make scripts executable
RUN chmod +x /app/voicetotext-linux/scripts/*.sh && \
    chmod +x /app/voicetotext-linux/install.sh

# Create directories for recordings and temp files
RUN mkdir -p /tmp/whisper-recordings

# Create a startup script
RUN echo '#!/bin/bash\n\
echo "🎙️ VoiceToText-Linux Docker Container"\n\
echo "Available models:"\n\
ls -la /app/whisper.cpp/models/ggml-*.bin\n\
echo ""\n\
echo "To use the system, run scripts from /app/voicetotext-linux/"\n\
echo "Example: ./scripts/switch-model.sh large-v3"\n\
echo ""\n\
echo "For voice transcription, use: ./scripts/whisper-toggle.sh"\n\
echo "(Note: Audio input/output requires additional Docker configuration)"\n\
bash' > /app/start.sh && chmod +x /app/start.sh

# Set working directory
WORKDIR /app/voicetotext-linux

# Default command
CMD ["/app/start.sh"]
