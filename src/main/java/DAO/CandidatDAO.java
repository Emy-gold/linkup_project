package DAO;

import Models.Candidat;
import java.util.List;

public interface CandidatDAO {
    void create(Candidat c);
    Candidat getById(int id);
    List<Candidat> getAll();
    void update(Candidat c);
    void delete(int id);
}