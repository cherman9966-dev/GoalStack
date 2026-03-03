allprojects {
    repositories {
        google()
        mavenCentral()
    }
}

val newBuildDir: Directory =
    rootProject.layout.buildDirectory
        .dir("../../build")
        .get()
rootProject.layout.buildDirectory.value(newBuildDir)

subprojects {
    val newSubprojectBuildDir: Directory = newBuildDir.dir(project.name)
    project.layout.buildDirectory.value(newSubprojectBuildDir)
}
subprojects {
    project.evaluationDependsOn(":app")
}

tasks.register<Delete>("clean") {
    delete(rootProject.layout.buildDirectory)
}

// Виправлення для Isar (встав це в кінець файлу android/build.gradle.kts)
subprojects {
    // Шукаємо саме бібліотеку Isar
    if (this.name == "isar_flutter_libs") {
        val project = this

        // Функція, яка встановлює namespace
        fun fixIsar() {
            try {
                val android = project.extensions.findByName("android")
                if (android != null) {
                    // Використовуємо рефлексію, щоб встановити namespace вручну
                    val setNamespace = android.javaClass.getMethod("setNamespace", String::class.java)
                    setNamespace.invoke(android, "dev.isar.isar_flutter_libs")
                }
            } catch (e: Exception) {
                println("Isar fix error: ${e.message}")
            }
        }

        // Головна перевірка: якщо проект вже готовий — лагодимо одразу.
        // Якщо ні — чекаємо завершення. Це прибирає помилку "Project already evaluated".
        if (project.state.executed) {
            fixIsar()
        } else {
            project.afterEvaluate { fixIsar() }
        }
    }
}