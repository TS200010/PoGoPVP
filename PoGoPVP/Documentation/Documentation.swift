//
//  AAA Documentation.swift
//  PoGoPVP
//
//  Created by Anthony Stanners on 12/08/2022.

// First time through, this is the root rule of the grammer. This funcion is called
//  recursively
//
// Search forward through the grammer until a TerminalSymbol is found AND it is TOKEN
// Failure on either of these conditions is a failure
//
// Get the first (possibly only) production for the current rule
//
// Walk through the productions of RULE looking for TOKEN as the first symbol.
// The PARSER stack keeps track of where we are in the Grammer (ie which rule and production)
//
// The LEXER tracks where we are in the source string.
//
// GRAMMER errors are NOT CHECKED
//

// Walk the SYNTAX_TREE in the GRAMMER :-
//   First look for a TOKEN starting PRODUCTION
//      If found then parse the ELEMENTS of the PRODUCTION
//
//   If not a TOKEN but a RULE then peek inside to see if TOKEN is down there
//      If it is then in we go (ie we call ourselves recursively. When we get back
//         we carry on parsing the ELEMENTs of the PRODUCTIO
//
//   If not a rule but a SEMANTIC ACTION then that is a SYNTAX ERROR as SAs
//   can only follow Ts and NTs (not RULES or other SAs)
//
// If we run out of PRODUCTIONS then that is a Stntax Error
//

//
// ----------------------- REPOSITORY COMPILER
//
// There is a GRAMMER struct for the grammers used by the application.
//
// There is a grammer that describes the content of the REPOSOURCE files that
//  populate the POGOREPOs...
//
// In order to allow the REPOSOURCE files maximum flexibility, there is a GRAMMER
//  that describes the syntax of the REPOSOURCE file grammer itself.
//
// This permits the following:
//      (1) Changes to the layout of the REPOSOURCE files to be made without code changes
//      (2) Changes to the ... finish this description
//
// GRAMMER( name, rootRule, tokenList )
//  |- name
//  |- rootRule
//  |- tokenList[]
//  |- rules[]
//  |- semanticActions[]
//  |- codeGeneratorActions[]
//
// The rules for a particular GRAMMER instance are created by the Static functions
//      CreateMetaParserGrammer()
//          Creates the rules statically - ie hard coded.
//      CreateRepoParserGrammer()
//          Creates the rules by invoking the Compiler itself to create the rules
//          in a form of bootstrap process.
//
// There is then a COMPILER to compile files.
//
// Compiling the the POGOREPO input files produces the POGOPREOs using PoGoPVPGrammer
//
// Compiling the MetaParserSyntax produces the grammer needed to parse the POGOREPO
// input files... Got that...!?
//
// The COMPILER orchestrates interactions between
// the processing elements (Lexer etc), the string being parsed, and the grammer.
// COMPILER( stringToParse, grammer )
//  |- *stringToParse
//  |- *grammer
//  |- lexer
//  |- parser
//  |- semAnalyser
//  |- codeGenerator
//
// The LEXER takes the STRING_TO_PARSE and using GRAMMER.TOKEN_LIST produces a stream of
// TOKENS that are consumed by the PARSER
//
// LEXER
//  |- *stringToParse
//
// The PARSER takes the TOKENS produced by the LEXER and starting at GRAMMER.ROOT_RULE parses
// this stream of tokens according to the RULES[]. In this process, the PARSER calls SEMANTIC_ACTIONS
// defined in the RULES[] to trigger semantic analysis and eventually code generation.
// PARSER
//  |- *grammer
//  |- semState
//
// SEMANTIC_ACTIONS[] is an array of functions called by the PARSER. Embedded in the RULES[] are
// {SEMANTIC_ACTIONS} the SEMANTIC_ACTION name being a string.
//
// The PARSER and the SEMANTIC_ACTIONS communicate using a stack called SEM_STATE. The PARSEr
// pushes items onto this stack... to be continued.
//
// The semAction table is a dictionary
// [ string: (semState)->semState ] ie a dictionery of functions that take a semState and
// return a new semState, indexed by a string which is the name of the SEMANTIC_ACTION.
// semState is a stack that is passed between semActions as orchestrated by the PARSER.
// semActions[]
//  |- semActName
//  |- (semState)->semState
//
// codeGenActions is an array of functions called by SEMANTIC_ACTIONS. Collectively, CODE_GEN_ACTIONs
// build trees whose nodes are array[something]. For example, in the case of the repo ENCYCLOPEDIA
// and COURSES the trees looks like:
//  root
//   |- [Encyclopedia Entry]
//       |- [Knowledge Item]
//
//  root(Courses)
//   |- [Course Entry]
//       |- [Course Item]
//
// codeGenActions operate on items conforming to the treeArrayNodeTraits protocol which defines
// objects that can be added, deleted and accessd to/from such trees.
//

// Some links for LL(1) Parser Table Construction
// https://www.geeksforgeeks.org/construction-of-ll1-parsing-table/
// https://andrewbegel.com/cs164/ll1.html
// https://www.codeproject.com/Articles/5162316/How-to-Make-an-LL-1-Parser-Lesson-3


typealias encId = Int
typealias courseId = Int
protocol treeArrayNodeTraits{}
struct Encyclopedia {
    let entries: [ encId: encyclopediaEntry ]
}
struct encyclopediaEntry : treeArrayNodeTraits {
    let relatedCourse: courseId
    let knowledgeItem: String // Strings for now
    let TestItem: String
    let HintItem: String
}

//
//
// ----------------------- POGOREPOs (Repositories)
//
// All data is held in repositories POGOREPOs.
// Some POGOREPOs are mutable, and others are immutable
//
// A POGOREPO is based on the protocol POGOREPO_TRAITS
//
// ----------------------- KNOWLEDGE
//
// The idea here is not to duplicate anything in the base Repositoriess
//   For example there are 16 different Type names for the student to learn
//      and each has an associated colour and image
//   This represent 3x16 (48) items of knowledge for the student to master
//   This just represents things the Student must learn, it has no relationship
//      to which course the Student will Study it
//   Later, the individual courses will probably group perhaps 4 Types, Colours and Images
//      into a Course for the Student to master. This may then be followed with a course
//      to master the names of some Pokemon that have this typings learnt. This may
//      then be followed with a Course to start learning the Type Effectiveness of the
//      Types in Defense etc etc,
//
// Knowledge consists of KNOWLEDGE_ITEMs
//      KNOWLEDGE_ITEMs have unique identifiers (But shared with TEST items)
//      KNOWLEDGE_ITEMs traits are captured in the KNOWLEDGE_ITEM_TRAITS protocol
//
// All KNOWLEDGE_ITEMs are kept in the ENCYCLOPEDIA
//      ENCYCLOPEDIA traits are captured in the ENCYCLOPEDIA_TRAITS protocol
//
//
// ----------------------- Pokemon Go Specific KNOWLEDGE-ITEMs
//
// There are ...
//    Type Names
//    Type Colours
//    Type Images
//    Type Kanji
//    Type Effectiveness Attack
//    Type Effectiveness Defense
//    ...AnotherKindOfKnowledge
//
// ----------------------- TESTs, QUESTIONS and ANSWERS
//
// STUDENTs are tested on their understanding of KNOWLEDGE-ITEMs with a TEST
//
// Each element of a SYLLABUS has a TEST.
//
// It is these TESTs that are entered into the LEITNER SYSTEM for study
//
//
// ----------------------- COURSEs, TOPICs and SYLABUSs
//
// A COURSE is the topmost area of study that a STUDENT can study
//      To take a COURSE a student studies a number of TOPICSs
//      The TOPICs to be studies are listed in the TOPIC_OUTLINE
//      COURSE traits are captured in the protocol COURSE_TRAITS
//
// A TOPIC_OUTLINE is a definition of the TOPICSs to be taken to studied for a COURSE
//      TOPIC_OUTLINE traits are captured in the protocol TOPIC_OUTLINE_TRAITS
//
// A TOPIC is the smallest unit that a STUDENT can study
//      Each TOPIC has a SYLLABUS defining the KNOWLEDGE-ITEMs to be studied
//      TOPIC traits are captured in the protocol TOPIC_TRAITS
//
// A SYLLABUS defines the KNOWLEDGE_ITEMs to be studied in a TOPIC
//      SYLLABUS traits are captured in the protocol SYLLABUS_TRAITS
//
// When a student starts to study a TOPIC, a copy of the TOPIC structure is made
//  and kept with the STUDENT. This copy is marked as the student progresses.
//  Note that the knowledge itself is not copied.
//
//
// ----------------------- STUDENTS
//
// It is a STUDENT that studies
//      A STUDENTs traits are captured in the protocol STUDENT_TRAITS
//
// A STUDENT gains recognition (BADGEs) for completing TOPICs and COURSEs
//
// ----------------------- THE LEITNER SYSTEM
//
// Studying  uses the Leitner scheduling system
// A good online reference for the system can be found here:
// https://fluent-forever.com/wp-content/uploads/2014/05/LeitnerSchedule.pdf
//
// A STUDENT studies in STUDY_SESSION
//
// In a STUDY_SESSION a STUDENT studies a number of BOXes
//
// The BOXes to study for a STUDY_SESSION are determined by the LEITNER_SCHEDULE
//      o The LEITNER_SCHEDULE is a cycle of 64 different sets of two or three BOXes to study
//      o Each STUDY_SESSION uses the next CURRENT_BOX_SET from the LEITNER_SCHEDULE
//
// TESTs move from box to box in accorance with the following rules
//      o TESTs start in BOX_! and advance to BOX_8
//          (Once in BOX_8, TESTs are considered to be complete)
//      o A TEST is moved as follows:
//          - If the student answers a challenge correctly, the item is advanced one box
//          - If the student answers a challenge incorrectly, the item is returned to BOX_1
//              (This needs to be easily changed)
//
// In each STUDY_SESSION, a number (NO_OF_SESSION_ITEMS) of TESTs are studied
//  (TESTs are drawn randomly from the boxes for the SESSION determined by the LEITNER_SCHEDULE)
//
// When a TOPIC is started, BOX_1 is primed with START_NUMBER_OF_ITEMS
//
// We start studying on SESSION 1 and the boxes to study are extracted from LEITNER_SCHEDULE
//
// Studying a TOPIC is primed as follows"
//      o Many questions are multiple choice drawn from items that have been introduced
//          NOT from the items in the boxes
//      o In SESSION 1 nothing has been studied yet so the multiple choice answer pool is empty
//      o KNOWLEDGE_ITEMS are introduced to the student until MULTIPLE_CHOICE_OPTIONS
//          have been introduced
//      o The KNOWLEDGE_ITEMS so introduced are placed in BOX_1
//
// A COURSE continues in the following manner ...
//      o The student is tested on randomly chosen items from the CURRENT_BOXES
//          - If the student answers correctly, the LEARNABLE is advanced to box n+1
//          - If the student answwrs incorrectly, the LEARNABLE is moved to BOX_1 <<PLACEHOLDER>>
//          - if the student answers a RELEGATED_ITEM incorrectly, the LEARNABLE is moved to BOX_1
//      o Every time a KNOWLEDGE_ITEMS is moved out of the CURRENT_BOX_SET
//          a new item is introduced to the student from the curret COURSE_LEVEL
//      o Testing continues until every KNOWLEDGE_ITEMS in the CURRENT_BOX_SET has been
//          presented to the student
//
// Progress is measured as follows:
//      o Progress is captured in a manner akin to a sound level bar IE the highest
//          level is remembered
//      o A TOPIC is considered mastered once all items from the course have accumulated in BOX_8
//      o A COURSE is consdered complete once all items have accumulated in BOX_8,
//
// A BADGE are earned when progress first reaches the complete/mastery threshold.
//      o Badges are not revoked if a student forgets something
//
// Review sessions are cheduled every REVIEW_SESSION_SCHEDULE sessions
//      o A review session differs from a regular study session in the following regards:
//          - Items are drawn randomly from BOX_8 only
//          - If the student fails to answer the question correctly, the LEARNABLE is
//              relegated to RELEGATION_BOX
//

