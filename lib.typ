#let pf(..lines) = {
  counter => {
    let result = array(())

    for line in lines.pos() {
      if (type(line) == array) {
        let (stmt, reason) = line
        result.push(
          grid(
            columns: (auto, auto, auto, 1fr),
            align: (left, left, left, right),
            $counter$, h(5%), stmt, reason,
          ),
        )
        counter += 1
      } else {
        assert.eq(type(line), function)
        let (counter_, x) = line(counter)
        result.push(x)
        counter = counter_
      }
    }
    (counter, grid(rows: result.len(), inset: 2pt, align: top, ..result))
  }
}

#let pfbox(..lines) = {
  i => {
    let (counter_, x) = pf(..lines)(i)
    (
      counter_,
      box(
        x,
        stroke: black,
      ),
    )
  }
}

#let cases(..boxes) = {
  i => {
    let result = array(())
    let counter = i

    for line in boxes.pos() {
      assert.eq(type(line), function)
      let (counter_, x) = line(counter)
      result.push(align(left + top, x))
      counter = counter_
    }

    (
      counter,
      table(
        columns: result.len(),
        align: top,
        ..result.map(col => [#col])
      ),
    )
  }
}
#let start(f) = {
  assert.eq(type(f), function)
  f(1).at(1)
}

// = Test
//
// #start(
//   pf(
//     ($forall x.A(x)$, [some reason]),
//     ($exists x.A(x)$, [trust me]),
//     pfbox(
//       ($forall x.A(x)$, [some reason]),
//       ($exists x.A(x)$, [trust me]),
//     ),
//     ($forall x.A(x)$, [some reason]),
//     cases(
//       pf(
//         ($forall x.A(x)$, [some reason]),
//         ($exists x.A(x)$, [trust me]),
//       ),
//       pf(
//         ($forall x.A(x)$, [some reason]),
//         ($exists x.A(x)$, [trust me]),
//       ),
//       pf(
//         ($forall x.A(x)$, [some reason]),
//         ($exists x.A(x)$, [trust me]),
//       ),
//     ),
//     cases(
//       pf(($forall x.A(x)$, [some reason])),
//       pf(
//         ($forall x.A(x)$, [some reason]),
//         ($exists x.A(x)$, [trust me]),
//         pfbox(
//           ($forall x.A(x)$, [some reason]),
//           ($exists x.A(x)$, [trust me]),
//           cases(
//             pf(
//               ($forall x.A(x)$, [f]),
//               ($exists x.A(x)$, [f]),
//             ),
//             pf(
//               ($forall x.A(x)$, [f]),
//               ($exists x.A(x)$, [f]),
//             ),
//           ),
//           ($exists x.A(x)$, [f]),
//         ),
//       ),
//     ),
//   ),
// )
