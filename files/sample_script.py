#!/usr/bin/env python

# inspired by snippets at 
# https://git.embl.de/grp-bio-it-workshops/intermediate-python

# Note: this file uses 4-space indentation
# Warning: don't name your script like a library you are importing
import argparse

# define arguments
parser=argparse.ArgumentParser()

# example, optional arg 'last'
parser.add_argument("--last", default=5, type=int,
        help="last sentence to check")

# actually parse args
args = parser.parse_args()

sentences = [
    "A list can hold any type of object",
    "A set is a type of object that doesn't keep element order",
    "A tuple, like a string, is an immutable type",
    "Strings are immutable, any change doesn't affect the original",
    "Dictionaries can only use immutable types as keys"
]

words = set(sentences[0].split(" "))

# iterate the remaining sentences
for i, sentence in enumerate(sentences[1:args.last]):
    words.intersection_update(sentence.split(" "))
    if words:
        print("Among the first", i+2, "sentences there are",
            len(words), "common words:", ", ".join(sorted(words)))
    else:
        print("After", i+2, "sentences, there are no common words")
        break

