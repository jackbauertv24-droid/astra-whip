class_name Stage
extends RefCounted
# Every surface: [first module, end exclusive, top row, kind, thickness].
# Thin overlapping treads are explicitly one-way to prevent crouch traps.
const SURFACES = [
 [0,8,0,"solid",320], [9,14,0,"one_way",16],
 [8,14,-2,"solid",192], [14,15,-1,"solid",256],
 [15,34,0,"solid",320], [35,41,0,"solid",320],
 [41,43,1,"solid",384], [43,45,2,"solid",448],
 [45,48,2,"one_way",16], [49,53,2,"one_way",16], [54,57,2,"one_way",16],
 [45,57,0,"solid",320], [55,56,1,"one_way",16],
 [57,104,0,"solid",320], [70,71,1,"one_way",16], [71,73,2,"one_way",16], [73,74,1,"one_way",16]
]
const ENCOUNTERS = [
 ["pursuer",1120,0,1024,1216], ["pursuer",1536,0,1408,1728],
 ["pursuer",1952,0,1792,2112], ["pursuer",2400,0,2304,2496],
 ["swooper",3264,2,3136,3648], ["pursuer",4384,0,4288,4480],
 ["ranged",4608,2,4608,4608], ["swooper",4896,0,4736,5056],
 ["boss",6240,0,5632,6528]
]
