package Models;

import java.util.Date;

public class candidature {

    private int id;
    private Date dateSoumission;
    private String statutCandidature;
    private String lettreMotivation;

    public candidature(){

    }


    public candidature(int id, Date dateSoumission, String statutCandidature, String lettreMotivation) {
        this.id = id;
        this.dateSoumission = dateSoumission;
        this.statutCandidature = statutCandidature;
        this.lettreMotivation = lettreMotivation;
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
}
