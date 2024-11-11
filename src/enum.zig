pub const CompileError = error {
  EndBackslash,
  EndBackslashC,
  UnknownEscape,
  QuantifierOutOfOrder,
  QuantifierTooBig,
  MissingSquareBracket,
  EscapeInvalidInClass,
  ClassRangeOrder,
  QuantifierInvalid,
  InternalUnexpectedRepeat,
  InvalidAfterParensQuery,
  PosixClassNotInClass,
  PosixNoSupportCollating,
  MissingClosingParenthesis,
  BadSubpatternReference,
  NullPattern,
  BadOptions,
  MissingCommentClosing,
  ParenthesesNestTooDeep,
  PatternTooLarge,
  HeapFailed,
  UnmatchedClosingParenthesis,
  InternalCodeOverflow,
  MissingConditionClosing,
  LookbehindNotFixedLength,
  ZeroRelativeReference,
  TooManyConditionBranches,
  ConditionAssertionExpected,
  BadRelativeReference,
  UnknownPosixClass,
  InternalStudyError,
  UnicodeNotSupported,
  ParenthesesStackCheck,
  CodePointTooBig,
  LookbehindTooComplicated,
  LookbehindInvalidBackslashC,
  UnsupportedEscapeSequence,
  CalloutNumberTooBig,
  MissingCalloutClosing,
  EscapeInvalidInVerb,
  UnrecognizedAfterQueryP,
  MissingNameTerminator,
  DuplicateSubpatternName,
  InvalidSubpatternName,
  UnicodePropertiesUnavailable,
  MalformedUnicodeProperty,
  UnknownUnicodeProperty,
  SubpatternNameTooLong,
  TooManyNamedSubpatterns,
  ClassInvalidRange,
  OctalByteTooBig,
  InternalOverranWorkspace,
  InternalMissingSubpattern,
  DefineTooManyBranches,
  BackslashOMissingBrace,
  InternalUnknownNewline,
  BackslashGSyntax,
  ParensQueryRMissingClosing,
  VerbArgumentNotAllowed,
  VerbUnknown,
  SubpatternNumberTooBig,
  SubpatternNameExpected,
  InternalParsedOverflow,
  InvalidOctal,
  SubpatternNamesMismatch,
  MarkMissingArgument,
  InvalidHexadecimal,
  BackslashCSyntax,
  BackslashKSyntax,
  InternalBadCodeLookbehinds,
  BackslashNInClass,
  CalloutStringTooLong,
  UnicodeDisallowedCodePoint,
  UTFIsDisabled,
  UcpIsDisabled,
  VerbNameTooLong,
  BackslashUCodePointTooBig,
  MissingOctalOrHexDigits,
  VersionConditionSyntax,
  InternalBadCodeAutoPossess,
  CalloutNoStringDelimiter,
  CalloutBadStringDelimiter,
  BackslashCCallerDisabled,
  QueryBarjxNestTooDeep,
  BackslashCLibraryDisabled,
  PatternTooComplicated,
  LookbehindTooLong,
  PatternStringTooLong,
  InternalBadCode,
  InternalBadCodeInSkip,
  noSurrogatesInUTF16,
  BadLiteralOptions,
  SupportedOnlyInUnicode,
  InvalidHyphenInOptions,
  AlphaAssertionUnknown,
  ScriptRunNotAvailable,
  TooManyCaptures,
  MissingOctalDigit,
  BackslashKInLookaround,
  MaxVarLookbehindExceeded,
  PatternCompiledSizeTooBig,
  OversizePythonOctal,
  CalloutCallerDisabled,
  ExtraCasingRequiresUnicode,
  TurkishCasingRequiresUTF,
  ExtraCasingIncompatible,
  EclassNestTooDeep,
  EclassInvalidOperator,
  EclassUnexpectedOperator,
  EclassExpectedOperand,
  EclassMixedOperators,
  EclassHintSquareBracket,
};

pub const MatchError = error {
  NoMatch,
  Partial,
  UTF8Err1,
  UTF8Err2,
  UTF8Err3,
  UTF8Err4,
  UTF8Err5,
  UTF8Err6,
  UTF8Err7,
  UTF8Err8,
  UTF8Err9,
  UTF8Err10,
  UTF8Err11,
  UTF8Err12,
  UTF8Err13,
  UTF8Err14,
  UTF8Err15,
  UTF8Err16,
  UTF8Err17,
  UTF8Err18,
  UTF8Err19,
  UTF8Err20,
  UTF8Err21,
  UTF16Err1,
  UTF16Err2,
  UTF16Err3,
  UTF32Err1,
  UTF32Err2,
  BadData,
  MixedTables,
  BadMagic,
  BadMode,
  BadOffset,
  BadOption,
  BadReplacement,
  BadUTFOffset,
  Callout,
  DFABadRestart,
  DFARecurse,
  DFAUcond,
  DFAUfunc,
  DFAUitem,
  DFAWssize,
  Internal,
  JITBadOption,
  JITStackLimit,
  MatchLimit,
  NoMemory,
  NoSubstring,
  NoUniqueSubstring,
  Null,
  Recurseloop,
  DepthLimit,
  RecursionLimit,
  Unavailable,
  Unset,
  BadOffsetLimit,
  BadRepEscape,
  RepMissingBrace,
  BadSubstitution,
  BadSubspattern,
  TooManyReplace,
  BadSerializedData,
  HeapLimit,
  ConvertSyntax,
  InternalDupmatch,
  DFAUinvalidUTF,
  InvalidOffset,
  JITUnsupported,
};

pub const CompileOptions = packed struct(u32) {
  allow_empty_class        : bool = false, // 0x00000001
  alt_bsux                 : bool = false, // 0x00000002
  auto_callout             : bool = false, // 0x00000004
  caseless                 : bool = false, // 0x00000008
  padding0                 : u1   = 0    ,
  dotall                   : bool = false, // 0x00000020
  dupnames                 : bool = false, // 0x00000040
  extended                 : bool = false, // 0x00000080
  padding1                 : u1   = 0    ,
  match_unset_backref      : bool = false, // 0x00000200
  multiline                : bool = false, // 0x00000400
  never_ucp                : bool = false, // 0x00000800
  never_utf                : bool = false, // 0x00001000
  no_auto_capture          : bool = false, // 0x00002000
  no_auto_possess          : bool = false, // 0x00004000
  no_dotstar_anchor        : bool = false, // 0x00008000
  padding2                 : u1   = 0    ,
  ucp                      : bool = false, // 0x00020000
  ungreedy                 : bool = false, // 0x00040000
  utf                      : bool = false, // 0x00080000
  never_backslash_c        : bool = false, // 0x00100000
  padding3                 : u1   = 0    ,
  alt_verbnames            : bool = false, // 0x00400000
  padding4                 : u1   = 0    ,
  extended_more            : bool = false, // 0x01000000
  literal                  : bool = false, // 0x02000000
  padding5                 : u1   = 0    ,
  alt_extended_class       : bool = false, // 0x08000000
  padding6                 : u1   = 0    ,
  endanchored              : bool = false, // 0x20000000
  no_utf_check             : bool = false, // 0x40000000
  anchored                 : bool = false, // 0x80000000
};

pub const CompileExtraOptions = packed struct(u32) {
  allow_surrogate_escapes  : bool = false, // 0x00000001
  bad_escape_is_literal    : bool = false, // 0x00000002
  match_word               : bool = false, // 0x00000004
  match_line               : bool = false, // 0x00000008
  escaped_cr_is_lf         : bool = false, // 0x00000010
  alt_bsux                 : bool = false, // 0x00000020
  allow_lookaround_bsk     : bool = false, // 0x00000040
  caseless_restrict        : bool = false, // 0x00000080
  ascii_bsd                : bool = false, // 0x00000100
  ascii_bss                : bool = false, // 0x00000200
  ascii_bsw                : bool = false, // 0x00000400
  ascii_posix              : bool = false, // 0x00000800
  ascii_digit              : bool = false, // 0x00001000
  python_octal             : bool = false, // 0x00002000
  no_bs0                   : bool = false, // 0x00004000
  never_callout            : bool = false, // 0x00008000
  turkish_casing           : bool = false, // 0x00010000
  padding0                 : u15  = 0    ,
};

pub const MatchOptions = packed struct(u32) {
  padding0                 : u4   = 0    ,
  dollar_endonly           : bool = false, // 0x00000010
  padding1                 : u3   = 0    ,
  firstline                : bool = false, // 0x00000100
  match_unset_backref      : bool = false, // 0x00000200
  padding2                 : u6   = 0    ,
  no_start_optimize        : bool = false, // 0x00010000
  ucp                      : bool = false, // 0x00020000
  padding3                 : u1   = 0    ,
  utf                      : bool = false, // 0x00080000
  padding4                 : u1   = 0    ,
  alt_circumflex           : bool = false, // 0x00200000
  padding5                 : u1   = 0    ,
  use_offset_limit         : bool = false, // 0x00800000
  padding6                 : u2   = 0    ,
  match_invalid_utf        : bool = false, // 0x04000000
  padding7                 : u2   = 0    ,
  endanchored              : bool = false, // 0x20000000
  no_utf_check             : bool = false, // 0x40000000
  anchored                 : bool = false, // 0x80000000
};