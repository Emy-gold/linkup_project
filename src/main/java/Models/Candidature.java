package Models;

import java.util.Date;

public class Candidature {

    private int id;
    private Date dateSoumission;
    private String statutCandidature;
    private String lettreMotivation;
    private int candidatId;
    private int annonceId;
    private int cvId; // AJOUT

    public Candidature(){}

    public Candidature(int id, Date dateSoumission, String statutCandidature, String lettreMotivation, int candidatId, int annonceId, int cvId) {
        this.id = id;
        this.dateSoumission = dateSoumission;
        this.statutCandidature = statutCandidature;
        this.lettreMotivation = lettreMotivation;
        this.candidatId = candidatId;
        this.annonceId = annonceId;
        this.cvId = cvId; // AJOUT
    }

    // Getters existants...
    public int getId() { return id; }
    public Date getDateSoumission() { return dateSoumission; }
    public String getStatutCandidature() { return statutCandidature; }
    public String getLettreMotivation() { return lettreMotivation; }
    public int getCandidatId() { return candidatId; }
    public int getAnnonceId() { return annonceId; }

    // AJOUT
    public int getCvId() { return cvId; }

    // Setters existants...
    public void setId(int id) { this.id = id; }
    public void setDateSoumission(Date dateSoumission) { this.dateSoumission = dateSoumission; }
    public void setLettreMotivation(String lettreMotivation) { this.lettreMotivation = lettreMotivation; }
    public void setStatutCandidature(String statutCandidature) { this.statutCandidature = statutCandidature; }
    public void setCandidatId(int candidatId) { this.candidatId = candidatId; }
    public void setAnnonceId(int annonceId) { this.annonceId = annonceId; }

    // AJOUT
    public void setCvId(int cvId) { this.cvId = cvId; }
}