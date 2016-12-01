package com.act.reachables;

import com.fasterxml.jackson.annotation.JsonCreator;
import com.fasterxml.jackson.annotation.JsonIgnore;
import com.fasterxml.jackson.annotation.JsonProperty;

import java.util.List;
import java.util.stream.Collectors;

public class ReactionPath {

  public List<Node> getPath() {
    return path;
  }

  public void setPath(List<Node> path) {
    this.path = path;
  }

  public String getId() {
    return id;
  }

  public void setId(String id) {
    this.id = id;
  }

  public Long getTarget() {
    return target;
  }

  public void setTarget(Long target) {
    this.target = target;
  }

  public Long getRank() {
    return rank;
  }

  public void setRank(Long rank) {
    this.rank = rank;
  }

  public Integer getDegree() {
    return degree;
  }

  public void setDegree(Integer degree) {
    this.degree = degree;
  }

  public Integer getReactionSum() {
    return reactionSum;
  }

  public void setReactionSum(Integer reactionSum) {
    this.reactionSum = reactionSum;
  }

  //@JsonProperty("path")
  private List<Node> path;

  @JsonProperty("_id")
  private String id;

  private Long target;
  private Long rank;
  private Integer degree;
  private Integer reactionSum;

  //@JsonCreator
  public ReactionPath() {}

  //@JsonCreator
  public ReactionPath(/*@JsonProperty("_id")*/ String id, /*@JsonProperty("path")*/ List<Node> path) {
    this.id = id;
    this.path = path;
    this.target = Long.parseLong(this.id.split("w")[0]);
    this.rank = Long.parseLong(this.id.split("w")[1]);
    this.degree = this.getReactionCount(this.path.get(1));
    this.reactionSum = this.path.stream().map(x -> getReactionCount(x)).collect(Collectors.summingInt(Integer::intValue));
  }

  //@JsonCreator
  public ReactionPath(List<Node> path, String id, Long target, Long rank, Integer degree, Integer reactionSum) {
    this.path = path;
    this.id = id;
    this.target = target;
    this.rank = rank;
    this.degree = degree;
    this.reactionSum = reactionSum;
  }

  @JsonIgnore
  private Integer getReactionCount(Node node) {
    // Only reactions contribute
    if (Boolean.parseBoolean((String) Node.getAttribute(node.id, "isrxn"))) {
      return Integer.parseInt((String) node.getAttribute("reaction_count"));
    } else {
      return 0;
    }
  }
}