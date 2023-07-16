# Use the official Flutter image as the base image
FROM cirrusci/flutter:2.10.5

# Set the working directory inside the container
WORKDIR /app

# Copy the pubspec.yaml and pubspec.lock files to the container
COPY pubspec.* ./

# Get the Flutter dependencies
RUN flutter pub get

# Copy the rest of the project files to the container
COPY . .

# Build the release APK
RUN flutter build apk --release

# Set the environment variables
ENV ANDROID_APK_PATH=/app/build/app/outputs/flutter-apk/app-release.apk

# Expose the APK as a volume
VOLUME /app/build/app/outputs/flutter-apk

# Run the Flutter app
CMD ["flutter", "run", "--release"]
