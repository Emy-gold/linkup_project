package DAO;

import Models.Entretien;

import java.util.List;

public interface EntretienDAO {

    public void create(Entretien e);
    public void delete(int id);
    public void update(Entretien e);
    List<Entretien> getAll();
    public Entretien getById(int id);
    List<Entretien> getByCandidatId(int candidatId);
    List<Entretien> getUpcomingByCandidatId(int candidatId, int limit);
    int countByCandidatId(int candidatId);


    // Create Entretient By Candidature
    void createEntretien(int candidatureId) throws Exception;

    //Get Entretient By RecruteurId
    List<Entretien> getByRecruteurId(int recruteurId) throws Exception;

}
