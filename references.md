# Websites

- [OpenCog Hyperon](https://hyperon.opencog.org)
  - [MeTTa](https://metta-lang.dev)
    - [Playground](https://metta-lang.dev/docs/playground/playground.html)
  - Socials
    - [YouTube: OpenCog Hyperon](https://www.youtube.com/@opencoghyperon)
    - [Discord: OpenCog Classic](https://discord.gg/vxPc6sz)
    - [Telegram: TrueAGI](https://t.me/TrueAGI)
    - [Twitter: TrueAGI](https://t.me/TrueAGI)

  - Medium
    - [SNET](https://medium.com/singularitynet)
      - [MeTTa in a nutshell](https://medium.com/singularitynet/metta-in-a-nutshell-exploring-the-language-of-agi-8d344c15b573)


# Language descriptions

- [OpenCog Hyperon: A Framework for AGI at the Human Level and Beyond](https://arxiv.org/abs/2310.18318)
  - In chapter "3.1.2 MeTTa in a Nutshell" Alexey provides an accessible, concise overview and motivation of the language.


# Language Specifications

- Alexey Potapov
  - [MeTTa Specification](https://wiki.opencog.org/w/File:MeTTa_Specification.pdf)

- Jonathan Warrell
  - [Math formulations underlying MeTTa language](https://www.youtube.com/watch?v=AYrsGDeZC1I)
  - [A meta-probabilistic-programming language for bisimulation of probabilistic and non-well-founded type systems](https://arxiv.org/abs/2203.15970)

- Greg Meredith
  - [Meta-MeTTa: an operational semantics for MeTTa](https://github.com/leithaus/rho4u/blob/main/ai/mops-short/mops-short.pdf)
    - on [arxiv](https://arxiv.org/abs/2305.17218)
  - [The MeTTa calculus](https://github.com/leithaus/rho4u/blob/main/metta-calculus/metta-calculus.pdf)



# Code

## Interpreters

- Alexey Potapov
  - [hyperon-experimental ("he")](https://github.com/trueagi-io/hyperon-experimental)
    - Rust

- Douglas Miles
  - [metta-wam ("mettalog")](https://github.com/trueagi-io/metta-wam)
    - Prolog

- Adam Vandervorst
  - [FormalMeTTa](https://github.com/Adam-Vandervorst/FormalMeTTa)
    - Scala
  - [CZ2](https://github.com/Adam-Vandervorst/CZ2)
    - Scala
  - [MORK](https://github.com/trueagi-io/MORK)
    - Rust with Zipper machines


## Examples

- [trueagi-io](https://github.com/trueagi-io)
  - [metta-examples](https://github.com/trueagi-io/metta-examples)
    - [SICP book](https://github.com/trueagi-io/metta-examples/tree/main/SICP_book)

  - [hyperon-experimental](https://github.com/trueagi-io/hyperon-experimental)
    - [scripts](https://github.com/trueagi-io/hyperon-experimental/tree/main/python/tests/scripts)

  - [chaining](https://github.com/trueagi-io/chaining)
    - [experimental](https://github.com/trueagi-io/chaining/tree/main/experimental)
      - many examples from Nil Geisweiler with good commentary
      - [calculi-converter.metta](https://github.com/trueagi-io/chaining/blob/main/experimental/converters/calculi-converter.metta)
        - lambda calculus, combinatory logic, and inter-conversions

### Talks

- [OpenCog Hyperon](https://www.youtube.com/@opencoghyperon)
  - [Alexey Potapov - MeTTa Language as a Tool for Creating DSLs](https://www.youtube.com/watch?v=33366EH49-Y)

- [AGI-24](https://www.youtube.com/watch?v=AxZo9eGGhGs&list=PLAJnaovHtaFQFUX5kp3d1UYmaUH_Ux8OL)
  - [Vitaly Bogdanov - Workshop on basics](https://youtu.be/t9PHKLmWbIg?t=326)
    - [metta-workshop-agi-24](https://github.com/vsbogd/metta-workshop-agi-24)
  - [Alexey Potapov - Workshop on metta-motto](https://youtu.be/t9PHKLmWbIg?t=6010)


## Libraries

- [zarqa-ai](https://github.com/zarqa-ai)
  - [metta-motto](https://github.com/zarqa-ai/metta-motto)

- [trueagi-io](https://github.com/trueagi-io)
  - [hyperon-moses](https://github.com/trueagi-io/hyperon-moses)
  - [hyperon-pln](https://github.com/trueagi-io/hyperon-pln)



# Special topics

## Knowledge graphs

- [metta-examples](https://github.com/trueagi-io/metta-examples)
  - [aunt-kg](https://github.com/trueagi-io/metta-examples/tree/main/aunt-kg)
    - dealing with regular labeled graphs
    - [issue 40: What is the canonical way to write queries to knowledge graph](https://github.com/trueagi-io/metta-examples/issues/40)
  - [traverser](https://github.com/trueagi-io/metta-examples/tree/main/traverser)
    - Tinkerpop's toy graph tinkerpop-modern.json
  - [edges-to-edges](https://github.com/trueagi-io/metta-examples/tree/main/edges-to-edges)
    - Examples of a generalization of semantic triples called Node Tagged Edges.

- [biocypher-kg](https://github.com/rejuve-bio/biocypher-kg)
  - [metta_writer.py](https://github.com/rejuve-bio/biocypher-kg/blob/main/biocypher_metta/metta_writer.py)
    - Creates three files: `type_defs.metta`, `nodes.metta`, `edges.metta`
      - Type definitions
        - `f.write(f"(: {node.upper()} Type)\n")`
        - `f.write(f"(<: {node.upper()} {ancestor.upper()})\n")` - subtypes as defined by Nil Geisweiler

- Example by Douglas Miles
  - [bio-atomspace](https://github.com/trueagi-io/metta-wam/blob/main/tests/extended_compat/bio-atomspace)
    - [type_defs.metta](https://github.com/trueagi-io/metta-wam/blob/main/tests/extended_compat/bio-atomspace/type_defs.metta)
    - uniprot
      - [nodes.metta and edges.metta](https://github.com/trueagi-io/metta-wam/tree/main/tests/extended_compat/bio-atomspace/uniprot) 


## Subtyping

- Nil Geisweiler
  - [Experiments on subtyping](https://github.com/trueagi-io/chaining/tree/main/experimental/subtyping)
  - [Use in AI-DSL](https://github.com/singnet/ai-dsl/blob/master/experimental/ai-service-composition/english-to-chinese-song-dtl-ontology-xp.metta)
