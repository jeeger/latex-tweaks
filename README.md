# latex-tweaks

Some latex tweaks that I've collected over my time writing LaTeX documents. The tweaks are: 

 - Inhibit auto-fill in tabular environments
 - Don't break lines on non-breaking spaces
 - Auto-escape underscores
 - Aligning the current environment (useful for tables).

A detailed writeup on the code is available [here](https://thenybble.de/projects/inhibit-auto-fill.html).

# Usage

```
(require 'latex-tweaks)
(LaTeX-tweaks-insinuate)
```
