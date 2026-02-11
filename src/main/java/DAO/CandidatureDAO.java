package DAO;

import Models.Candidature;

import java.util.List;

public interface CandidatureDAO {

    public void create(Candidature c);

    Candidature getById(int id);

    List<Candidature> getAll();

    public void update(Candidature c);

    public void delete(int id);

    List<Candidature> getByCandidatId(int candidatId);

    List<Candidature> getByAnnonceId(int annonceId);

    List<Candidature> getByCandidatureIdAndStatut(int candidatId, String statut);

    List<Candidature> getRecentByCandidatId(int candidatId, int limit);

    int countByCandidatId(int candidatId);

    int countByRecruteurId(int recruteurId);
}
