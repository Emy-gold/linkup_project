package DAO;

import Models.Annonce;

import java.util.List;

public interface AnnonceDAO {

    public void create(Annonce a);
    public void update(Annonce a);
    public void delete(int id);
    List<Annonce> getAll();
    public Annonce getById(int id);
    List<Annonce> getByRecruteurId(int recruteurId);
    List<Annonce> getByTypeContrat(String typeContrat);
    List<Annonce> search(String keyword);
    List<Annonce> getRecent(int limit);
}
