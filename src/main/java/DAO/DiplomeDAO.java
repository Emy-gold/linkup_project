package DAO;

import Models.Diplome;
import java.util.List;

public interface DiplomeDAO {

    void create(Diplome d);
    Diplome getById(int id);
    List<Diplome> getAll();
    void update(Diplome d);
    void delete(int id);
    List<Diplome> getByCandidatId(int candidatId);
    int countByCandidatId(int candidatId);
}