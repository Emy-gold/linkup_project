package DAO;
import Models.Recruteur;

import java.util.List;

public interface RecruteurDAO {

    public void create(Recruteur r);
    public void update(Recruteur r);
    public void delete(int id);

    public List<Recruteur> getAll();

    public Recruteur getById(int id);

    Recruteur getByUserId(int userId);   // pour Login recruteur

    boolean existsByUserId(int userId); //check if exists and login


}
