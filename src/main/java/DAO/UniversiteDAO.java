package DAO;

import Models.Universite;
import java.util.List;

public interface UniversiteDAO {
    List<Universite> getAllUniversites();
    Universite getUniversiteById(int idUniversite);
    boolean createUniversite(Universite univ);
    Universite getUniversiteByAgentId(int agentId);
}