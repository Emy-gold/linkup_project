package DAO;

import Models.Diplome;
import java.util.List;

public interface diplomeDAO {
    // CRUD de base
    void create(Diplome d);
    Diplome getById(int id);
    List<Diplome> getAll();
    void update(Diplome d);
    void delete(int id);

    // Méthodes pour candidat
    List<Diplome> getByCandidatId(int candidatId);
    int countByCandidatId(int candidatId);

    // Méthodes pour filtres
    List<Diplome> getByStatutValidation(String statut);

    // Méthodes pour agent universitaire
    List<Diplome> getDiplomesEnAttente(int idUniversite);
    List<Diplome> getDiplomesHistorique(int idUniversite);
    boolean validerDiplome(int idDiplome);
    boolean rejeterDiplome(int idDiplome);
}