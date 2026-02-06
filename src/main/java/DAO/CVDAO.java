package DAO;

import Models.Cv;

import java.util.List;

public interface CVDAO {

    public void create(Cv cv);
    public void update(Cv cv);
    public void delete(int id);
    List<Cv> getAll();
    public Cv getById(int id);
    List<Cv> getByCandidatId(int candidatId);
    int countByCandidatId(int candidatId);

}
