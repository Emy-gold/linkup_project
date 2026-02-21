package Utils;

import java.io.File;

public class FileUploadConfig {
    // Chemin absolu vers le dossier webapp du projet pour la persistance en développement
    // Note: Dans un environnement de production réel, on utiliserait un chemin hors du dossier de déploiement
    public static final String PROJECT_ROOT = "c:/Users/victus/IdeaProjects/linkup_project";
    public static final String UPLOAD_BASE_PATH = PROJECT_ROOT + "/src/main/webapp/uploads";
    
    public static final String UPLOAD_PATH_CVS = UPLOAD_BASE_PATH + "/cvs";
    public static final String UPLOAD_PATH_DIPLOMES = UPLOAD_BASE_PATH + "/diplomes";

    static {
        // S'assurer que les dossiers existent
        new File(UPLOAD_PATH_CVS).mkdirs();
        new File(UPLOAD_PATH_DIPLOMES).mkdirs();
    }
}
