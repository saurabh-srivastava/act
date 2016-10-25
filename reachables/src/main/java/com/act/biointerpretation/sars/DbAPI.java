package com.act.biointerpretation.sars;

import act.server.MongoDB;
import act.shared.Chemical;
import act.shared.Reaction;
import chemaxon.formats.MolFormatException;
import chemaxon.struc.Molecule;
import chemaxon.struc.RxnMolecule;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

public class DbAPI {

  private final MongoDB db;
  private Map<Long, Chemical> chemicalCache;
  private Map<Long, Reaction> reactionCache;

  public DbAPI(MongoDB db) {
    this.db = db;
    chemicalCache = new HashMap<>();
    reactionCache = new HashMap<>();
  }

  public static boolean areAllOneSubstrate(List<RxnMolecule> reactions) {
    for (RxnMolecule reaction : reactions) {
      if (reaction.getReactantCount() != 1) {
        return false;
      }
    }
    return true;
  }

  public static boolean areAllOneProduct(List<RxnMolecule> reactions) {
    for (RxnMolecule reaction : reactions) {
      if (reaction.getProductCount() != 1) {
        return false;
      }
    }
    return true;
  }

  public void clearCaches() {
    chemicalCache = new HashMap<>();
    reactionCache = new HashMap<>();
  }

  public Chemical getChemical(Long id) {
    Chemical result = chemicalCache.get(id);
    if (result == null) {
      result = db.getChemicalFromChemicalUUID(id);
      chemicalCache.put(id, result);
    }
    return result;
  }

  public Reaction getReaction(Long id) {
    Reaction result = reactionCache.get(id);
    if (result == null) {
      result = db.getReactionFromUUID(id);
      reactionCache.put(id, result);
    }
    return result;
  }

  public List<Reaction> getReactions(ReactionGroup group) {
    return new ArrayList<>(group.getReactionIds()).stream()
        .map(id -> getReaction(id)).collect(Collectors.toList());
  }

  public List<RxnMolecule> getRxnMolecules(List<Reaction> reactions) {
    return reactions.stream().map(reaction -> getRxnMolecule(reaction)).collect(Collectors.toList());
  }

  public RxnMolecule getRxnMolecule(Reaction reaction) {
    RxnMolecule result = new RxnMolecule();
    getSubstratesAsMolecules(reaction).forEach(mol -> result.addComponent(mol, RxnMolecule.REACTANTS));
    getProductsAsMolecules(reaction).forEach(mol -> result.addComponent(mol, RxnMolecule.PRODUCTS));
    return result;
  }

  public List<Molecule> getSubstratesAsMolecules(Reaction reaction) {
    return Arrays.asList(reaction.getSubstrates()).stream()
        .map(id -> importMolecule(getChemical(id))).collect(Collectors.toList());
  }

  public List<Molecule> getProductsAsMolecules(Reaction reaction) {
    return Arrays.asList(reaction.getSubstrates()).stream()
        .map(id -> importMolecule(getChemical(id))).collect(Collectors.toList());
  }

  public Molecule importMolecule(Chemical chemical) {
    try {
      return chemical.importAsMolecule();
    } catch (MolFormatException e) {
      throw new IllegalArgumentException("DbAPI couldn't import chemical:" + e.getMessage());
    }
  }

}