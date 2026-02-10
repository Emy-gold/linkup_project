package Models;

import java.util.Date;

public class Candidature {

    private int id;
    private Date dateSoumission;
    private String statutCandidature;
    private String lettreMotivation;

    // les foreign keys
    private int candidatId;
    private int annonceId;

    public Candidature(){
    }
    public Candidature(int id, Date dateSoumission, String statutCandidature, String lettreMotivation, int candidatId, int annonceId) {
        this.id = id;
        this.dateSoumission = dateSoumission;
        this.statutCandidature = statutCandidature;
        this.lettreMotivation = lettreMotivation;
        this.candidatId = candidatId;
        this.annonceId = annonceId;
    }

    public int getId() {
        return id;
    }

    public Date getDateSoumission() {
        return dateSoumission;
    }

    public String getStatutCandidature() {
        return statutCandidature;
    }

    public String getLettreMotivation() {
        return lettreMotivation;
    }

    public int getCandidatId() {
        return candidatId;
    }

    public int getAnnonceId() {
        return annonceId;
    }

    public void setId(int id) {
        this.id = id;
    }

    public void setDateSoumission(Date dateSoumission) {
        this.dateSoumission = dateSoumission;
    }

    public void setLettreMotivation(String lettreMotivation) {
        this.lettreMotivation = lettreMotivation;
    }

    public void setStatutCandidature(String statutCandidature) {
        this.statutCandidature = statutCandidature;
    }

    public void setCandidatId(int candidatId) {
        this.candidatId = candidatId;
    }

    public void setAnnonceId(int annonceId) {
        this.annonceId = annonceId;
    }
}
