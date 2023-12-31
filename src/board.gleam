import bitboard.{type Bitboard, and, new_bitboard, shift_left}
import position.{type Position}
import piece.{type Piece, Bishop, King, Knight, Pawn, Queen, Rook}
import color.{Black, White}
import gleam/option.{None, Some}
import gleam/list
import gleam/set

pub type BoardBB {
  BoardBB(
    black_king_bitboard: bitboard.Bitboard,
    black_queen_bitboard: bitboard.Bitboard,
    black_rook_bitboard: bitboard.Bitboard,
    black_bishop_bitboard: bitboard.Bitboard,
    black_knight_bitboard: bitboard.Bitboard,
    black_pawns_bitboard: bitboard.Bitboard,
    white_king_bitboard: bitboard.Bitboard,
    white_queen_bitboard: bitboard.Bitboard,
    white_rook_bitboard: bitboard.Bitboard,
    white_bishop_bitboard: bitboard.Bitboard,
    white_knight_bitboard: bitboard.Bitboard,
    white_pawns_bitboard: bitboard.Bitboard,
  )
}

pub fn remove_piece_at_position(
  board: BoardBB,
  position: Position,
) -> option.Option(BoardBB) {
  let bitboard = bitboard.not(from_position(position))

  let new_board = case get_piece_at_position(board, position) {
    None -> None
    Some(piece.Piece(color: color, kind: kind)) if color == White && kind == King -> {
      Some(
        BoardBB(
          ..board,
          white_king_bitboard: bitboard.and(bitboard, board.white_king_bitboard),
        ),
      )
    }
    Some(piece.Piece(color: color, kind: kind)) if color == White && kind == Queen -> {
      Some(
        BoardBB(
          ..board,
          white_queen_bitboard: bitboard.and(
            bitboard,
            board.white_queen_bitboard,
          ),
        ),
      )
    }
    Some(piece.Piece(color: color, kind: kind)) if color == White && kind == Rook -> {
      Some(
        BoardBB(
          ..board,
          white_rook_bitboard: bitboard.and(bitboard, board.white_rook_bitboard),
        ),
      )
    }

    Some(piece.Piece(color: color, kind: kind)) if color == White && kind == Bishop -> {
      Some(
        BoardBB(
          ..board,
          white_bishop_bitboard: bitboard.and(
            bitboard,
            board.white_bishop_bitboard,
          ),
        ),
      )
    }
    Some(piece.Piece(color: color, kind: kind)) if color == White && kind == Knight -> {
      Some(
        BoardBB(
          ..board,
          white_knight_bitboard: bitboard.and(
            bitboard,
            board.white_knight_bitboard,
          ),
        ),
      )
    }
    Some(piece.Piece(color: color, kind: kind)) if color == White && kind == Pawn -> {
      Some(
        BoardBB(
          ..board,
          white_pawns_bitboard: bitboard.and(
            bitboard,
            board.white_pawns_bitboard,
          ),
        ),
      )
    }
    Some(piece.Piece(color: color, kind: kind)) if color == Black && kind == King -> {
      Some(
        BoardBB(
          ..board,
          black_king_bitboard: bitboard.and(bitboard, board.black_king_bitboard),
        ),
      )
    }
    Some(piece.Piece(color: color, kind: kind)) if color == Black && kind == Queen -> {
      Some(
        BoardBB(
          ..board,
          black_queen_bitboard: bitboard.and(
            bitboard,
            board.black_queen_bitboard,
          ),
        ),
      )
    }
    Some(piece.Piece(color: color, kind: kind)) if color == Black && kind == Rook -> {
      Some(
        BoardBB(
          ..board,
          black_rook_bitboard: bitboard.and(bitboard, board.black_rook_bitboard),
        ),
      )
    }
    Some(piece.Piece(color: color, kind: kind)) if color == Black && kind == Bishop -> {
      Some(
        BoardBB(
          ..board,
          black_bishop_bitboard: bitboard.and(
            bitboard,
            board.black_bishop_bitboard,
          ),
        ),
      )
    }
    Some(piece.Piece(color: color, kind: kind)) if color == Black && kind == Knight -> {
      Some(
        BoardBB(
          ..board,
          black_knight_bitboard: bitboard.and(
            bitboard,
            board.black_knight_bitboard,
          ),
        ),
      )
    }
    Some(piece.Piece(color: color, kind: kind)) if color == Black && kind == Pawn -> {
      Some(
        BoardBB(
          ..board,
          black_pawns_bitboard: bitboard.and(
            bitboard,
            board.black_pawns_bitboard,
          ),
        ),
      )
    }
    _ -> {
      panic("Invalid piece")
    }
  }
  new_board
}

pub fn set_piece_at_position(
  board: BoardBB,
  position: Position,
  piece: Piece,
) -> BoardBB {
  let bitboard = from_position(position)

  let new_board = case piece {
    piece.Piece(color: color, kind: kind) if color == White && kind == King -> {
      BoardBB(
        ..board,
        white_king_bitboard: bitboard.or(bitboard, board.white_king_bitboard),
      )
    }
    piece.Piece(color: color, kind: kind) if color == White && kind == Queen -> {
      BoardBB(
        ..board,
        white_queen_bitboard: bitboard.or(bitboard, board.white_queen_bitboard),
      )
    }
    piece.Piece(color: color, kind: kind) if color == White && kind == Rook -> {
      BoardBB(
        ..board,
        white_rook_bitboard: bitboard.or(bitboard, board.white_rook_bitboard),
      )
    }
    piece.Piece(color: color, kind: kind) if color == White && kind == Bishop -> {
      BoardBB(
        ..board,
        white_bishop_bitboard: bitboard.or(
          bitboard,
          board.white_bishop_bitboard,
        ),
      )
    }
    piece.Piece(color: color, kind: kind) if color == White && kind == Knight -> {
      BoardBB(
        ..board,
        white_knight_bitboard: bitboard.or(
          bitboard,
          board.white_knight_bitboard,
        ),
      )
    }
    piece.Piece(color: color, kind: kind) if color == White && kind == Pawn -> {
      BoardBB(
        ..board,
        white_pawns_bitboard: bitboard.or(bitboard, board.white_pawns_bitboard),
      )
    }
    piece.Piece(color: color, kind: kind) if color == Black && kind == King -> {
      BoardBB(
        ..board,
        black_king_bitboard: bitboard.or(bitboard, board.black_king_bitboard),
      )
    }
    piece.Piece(color: color, kind: kind) if color == Black && kind == Queen -> {
      BoardBB(
        ..board,
        black_queen_bitboard: bitboard.or(bitboard, board.black_queen_bitboard),
      )
    }
    piece.Piece(color: color, kind: kind) if color == Black && kind == Rook -> {
      BoardBB(
        ..board,
        black_rook_bitboard: bitboard.or(bitboard, board.black_rook_bitboard),
      )
    }
    piece.Piece(color: color, kind: kind) if color == Black && kind == Bishop -> {
      BoardBB(
        ..board,
        black_bishop_bitboard: bitboard.or(
          bitboard,
          board.black_bishop_bitboard,
        ),
      )
    }
    piece.Piece(color: color, kind: kind) if color == Black && kind == Knight -> {
      BoardBB(
        ..board,
        black_knight_bitboard: bitboard.or(
          bitboard,
          board.black_knight_bitboard,
        ),
      )
    }
    piece.Piece(color: color, kind: kind) if color == Black && kind == Pawn -> {
      BoardBB(
        ..board,
        black_pawns_bitboard: bitboard.or(bitboard, board.black_pawns_bitboard),
      )
    }
    _ -> {
      panic("Invalid piece")
    }
  }
  new_board
}

pub fn get_piece_at_position(board: BoardBB, position: Position) {
  let bitboard = from_position(position)
  let black_king_bb_compare = bitboard.and(board.black_king_bitboard, bitboard)
  let black_queen_bb_compare =
    bitboard.and(board.black_queen_bitboard, bitboard)
  let black_rook_bb_compare = bitboard.and(board.black_rook_bitboard, bitboard)
  let black_bishop_bb_compare =
    bitboard.and(board.black_bishop_bitboard, bitboard)
  let black_knight_bb_compare =
    bitboard.and(board.black_knight_bitboard, bitboard)
  let black_pawns_bb_compare =
    bitboard.and(board.black_pawns_bitboard, bitboard)
  let white_king_bb_compare = bitboard.and(board.white_king_bitboard, bitboard)
  let white_queen_bb_compare =
    bitboard.and(board.white_queen_bitboard, bitboard)
  let white_rook_bb_compare = bitboard.and(board.white_rook_bitboard, bitboard)
  let white_bishop_bb_compare =
    bitboard.and(board.white_bishop_bitboard, bitboard)
  let white_knight_bb_compare =
    bitboard.and(board.white_knight_bitboard, bitboard)
  let white_pawns_bb_compare =
    bitboard.and(board.white_pawns_bitboard, bitboard)

  let piece = case bitboard.bitboard {
    0 -> None
    _ -> {
      let piece = case bitboard {
        _ if bitboard == black_king_bb_compare ->
          Some(piece.Piece(color.Black, King))
        _ if bitboard == black_queen_bb_compare ->
          Some(piece.Piece(color.Black, Queen))
        _ if bitboard == black_rook_bb_compare ->
          Some(piece.Piece(color.Black, Rook))
        _ if bitboard == black_bishop_bb_compare ->
          Some(piece.Piece(color.Black, Bishop))
        _ if bitboard == black_knight_bb_compare ->
          Some(piece.Piece(color.Black, Knight))
        _ if bitboard == black_pawns_bb_compare ->
          Some(piece.Piece(color.Black, Pawn))
        _ if bitboard == white_king_bb_compare ->
          Some(piece.Piece(color.White, King))
        _ if bitboard == white_queen_bb_compare ->
          Some(piece.Piece(color.White, Queen))
        _ if bitboard == white_rook_bb_compare ->
          Some(piece.Piece(color.White, Rook))
        _ if bitboard == white_bishop_bb_compare ->
          Some(piece.Piece(color.White, Bishop))
        _ if bitboard == white_knight_bb_compare ->
          Some(piece.Piece(color.White, Knight))
        _ if bitboard == white_pawns_bb_compare ->
          Some(piece.Piece(color.White, Pawn))
        _ -> None
      }
      piece
    }
  }
  piece
}

pub fn get_all_positions(board: BoardBB) -> List(Position) {
  let list_of_bitboards = [
    board.black_king_bitboard,
    board.black_queen_bitboard,
    board.black_rook_bitboard,
    board.black_bishop_bitboard,
    board.black_knight_bitboard,
    board.black_pawns_bitboard,
    board.white_king_bitboard,
    board.white_queen_bitboard,
    board.white_rook_bitboard,
    board.white_bishop_bitboard,
    board.white_knight_bitboard,
    board.white_pawns_bitboard,
  ]

  let positions =
    list.fold(
      list_of_bitboards,
      set.new(),
      fn(acc, bitboard) {
        let positions = get_positions(bitboard)
        let positions = set.from_list(positions)
        set.union(acc, positions)
      },
    )

  set.to_list(positions)
}

pub fn get_positions(bitboard: Bitboard) -> List(Position) {
  let positions = []
  case bitboard.bitboard {
    0 -> positions
    _ -> {
      let count = 63
      let just_first_bit_of_bb = and(bitboard, new_bitboard(0x8000000000000000))
      case just_first_bit_of_bb.bitboard {
        0 -> get_positions_inner(shift_left(bitboard, 1), count - 1)
        _ -> {
          let assert Some(position_dest) = position.from_int(count)
          [
            position_dest,
            ..get_positions_inner(shift_left(bitboard, 1), count - 1)
          ]
        }
      }
    }
  }
}

pub fn get_positions_inner(bitboard: Bitboard, count: Int) -> List(Position) {
  case count < 0 {
    True -> []
    False -> {
      let just_first_bit_of_bb = and(bitboard, new_bitboard(0x8000000000000000))
      case just_first_bit_of_bb.bitboard {
        0 -> get_positions_inner(shift_left(bitboard, 1), count - 1)
        _ -> {
          let assert Some(position_dest) = position.from_int(count)
          [
            position_dest,
            ..get_positions_inner(shift_left(bitboard, 1), count - 1)
          ]
        }
      }
    }
  }
}

pub fn from_position(position: Position) -> Bitboard {
  let bitboard = shift_left(new_bitboard(1), position.to_int(position))
  bitboard
}
