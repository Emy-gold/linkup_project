package Models;

public class Activity {
    private String titre;
    private String description;
    private String date;

    public Activity(String titre, String description, String date) {
        this.titre = titre;
        this.description = description;
        this.date = date;
    }

    public String getTitre() { return titre; }
    public void setTitre(String titre) { this.titre = titre; }

    public String getDescription() { return description; }
    public void setDescription(String description) { this.description = description; }

    public String getDate() { return date; }
    public void setDate(String date) { this.date = date; }
}
