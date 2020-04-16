#!/usr/bin/env cwl-runner
#
# Score
#
cwlVersion: v1.0
class: CommandLineTool
baseCommand: [Rscript, /usr/local/bin/score.R]

hints:
  DockerRequirement:
    dockerPull: docker.synapse.org/syn21763590/scoring:v1

inputs:
  - id: inputfile
    type: File
  - id: gold_pval
    type: File
  - id: gold_auc
    type: File
  - id: check_validation_finished
    type: boolean?

arguments:
  - valueFrom: $(inputs.inputfile.path)
    prefix: --inputfile
  - valueFrom: $(inputs.gold_pval.path)
    prefix: --pval
  - valueFrom: $(inputs.gold_auc.path)
    prefix: --auc
  - valueFrom: results.json
    prefix: --results

requirements:
  - class: InlineJavascriptRequirement
     
outputs:
  - id: results
    type: File
    outputBinding:
      glob: results.json