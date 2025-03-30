# Reverse Polish Notation (RPN)

The reverse version of the [Prefix Polish Notation](https://en.wikipedia.org/wiki/Polish_notation), or simply Prefix Notation.

Unlike the prefix notation, in which operators precede operands, its operators follow the operands.

```
10 7 4 + * 2 -
```

Is the same as:

```
(7 + 4) * 10 - 2
```

## Testing

My implementation don't parse the string to grab each operator or operand. To focus only in the feature itself, the `solve/1` function receives the list with the expression.

To use an operator, use their respective `atom`:

| Atom   | Operator | Operands  | Description                  |
| ------ | -------- | --------- | ---------------------------- |
| `add`  | `+`      | `A` | `B` | Adds operands `A` and `B`    |
| `sub`  | `-`      | `A` | `B` | Subtracts operand `B` to `A` |
| `mul`  | `*`      | `A` | `B` | Multiply operand `B` to `A`  |
| `tdiv` | `/`      | `A` | `B` | Divides operand `A` by `B`   |
| `pow`  | `^`      | `A`       | Power the operand `A` by 2   |

```erl
rpn:solve([10, 7, 4, add, mul, 2, tdiv]).
```
> It must returns `{ ok, 55.0 }`
