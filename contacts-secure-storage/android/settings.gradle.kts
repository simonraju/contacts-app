pluginManagement {
<<<<<<< HEAD
    val flutterSdkPath = run {
        val properties = java.util.Properties()
        file("local.properties").inputStream().use { properties.load(it) }
        val flutterSdkPath = properties.getProperty("flutter.sdk")
        require(flutterSdkPath != null) { "flutter.sdk not set in local.properties" }
        flutterSdkPath
    }
=======
    val flutterSdkPath =
        run {
            val properties = java.util.Properties()
            file("local.properties").inputStream().use { properties.load(it) }
            val flutterSdkPath = properties.getProperty("flutter.sdk")
            require(flutterSdkPath != null) { "flutter.sdk not set in local.properties" }
            flutterSdkPath
        }
>>>>>>> 584f9de (contacts-secure-storage commit)

    includeBuild("$flutterSdkPath/packages/flutter_tools/gradle")

    repositories {
        google()
        mavenCentral()
        gradlePluginPortal()
    }
}

plugins {
    id("dev.flutter.flutter-plugin-loader") version "1.0.0"
<<<<<<< HEAD
    id("com.android.application") version "8.7.3" apply false
=======
    id("com.android.application") version "8.9.1" apply false
>>>>>>> 584f9de (contacts-secure-storage commit)
    id("org.jetbrains.kotlin.android") version "2.1.0" apply false
}

include(":app")
