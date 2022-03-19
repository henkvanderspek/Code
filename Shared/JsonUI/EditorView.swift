//
//  EditorView.swift
//  Code
//
//  Created by Henk van der Spek on 14/03/2022.
//

import Foundation
import CoreGraphics
import Sourceful

protocol EditorViewDelegate: AnyObject {
    func didChangeText(_ s: String, in editorView: EditorView)
}

class EditorView: NativeView {
    
    weak var delegate: EditorViewDelegate?
    
    private lazy var syntaxTextView: SyntaxTextView = {
        let v = SyntaxTextView()
        v.translatesAutoresizingMaskIntoConstraints = false
        v.delegate = self
        v.theme = EditorTheme()
        v.contentTextView.alwaysBounceVertical = true
        v.adjustContentInset(.top(20))
        return v
    }()

    override init(frame: CGRect = .zero) {
        super.init(frame: frame)
        backgroundColor = syntaxTextView.theme?.backgroundColor
        addSubview(syntaxTextView)
        syntaxTextView.constraint(to: self, priorities: .required).activate()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private var internalSetText = false
    
    var text: String? {
        set {
            syntaxTextView.text = newValue ?? ""
        }
        get {
            syntaxTextView.text
        }
    }
}

extension EditorView: SyntaxTextViewDelegate {
    func lexerForSource(_ source: String) -> Lexer {
        // TODO: Improve this lexer to ignore keywords inside strings
        // Also it shows urls within strings as comments
        JavaScriptLexer()
    }
    func didChangeText(_ syntaxTextView: SyntaxTextView) {
        delegate?.didChangeText(syntaxTextView.text, in: self)
    }
}

private struct EditorTheme: SourceCodeTheme {

    static let f: NativeFont = .monospacedSystemFont(ofSize: 12.0, weight: .medium)
    static let f2: NativeFont = .systemFont(ofSize: 11.0, weight: .regular)
    
    let backgroundColor: NativeColor = .systemBackground
    let lineNumbersStyle: LineNumbersStyle? = .init(font: f2, textColor: .systemGray2)
    let gutterStyle: GutterStyle = GutterStyle(backgroundColor: .systemBackground, minimumWidth: 32)
    let font = f
    
    func color(for syntaxColorType: SourceCodeTokenType) -> Sourceful.Color {
        switch syntaxColorType {
        case .plain:
            return .label
        case .number:
            return .systemBlue
        case .string:
            return .red
        case .identifier:
            return .label
        case .keyword:
            return .systemPink
        case .comment:
            return .systemGray3
        case .editorPlaceholder:
            return .systemGray3
        }
    }
}

class JavaScriptLexer: SourceCodeRegexLexer {
    
    lazy var generators: [TokenGenerator] = {
        
        var generators = [TokenGenerator?]()
        
        // Functions
        
        generators.append(regexGenerator("\\b(System.out.print|System.out.printL)(?=\\()", tokenType: .identifier))
        
        generators.append(regexGenerator("(?<=(\\s|\\[|,|:))(\\d|\\.|_)+", tokenType: .number))
        
        generators.append(regexGenerator("\\.[A-Za-z_]+\\w*", tokenType: .identifier))
        
        let keywords = "abstract arguments await boolean break byte case catch char class    const continue debugger default delete do double else enum eval export extends false final finally float for function goto if implements import in instanceof int interface let long native new null package private protected public return short static super switch synchronized this throw throws transient true try typeof var void volatile while with yield".components(separatedBy: " ")
        
        let builtInObjectsIdentifiers = "Infinity NaN undefined null globalThis Object Function Boolean Symbol Error AggregateError  EvalError InternalError  RangeError ReferenceError SyntaxError TypeError URIError Number BigInt Math Date String RegExp Array Int8Array Uint8Array Uint8ClampedArray Int16Array Uint16Array Int32Array Uint32Array Float32Array Float64Array BigInt64Array BigUint64Array Map Set WeakMap WeakSet ArrayBuffer SharedArrayBuffer  Atomics  DataView JSON Promise Generator GeneratorFunction AsyncFunction Iterator  AsyncIterator  Reflect Proxy Intl Intl.Collator Intl.DateTimeFormat Intl.ListFormat Intl.NumberFormat Intl.PluralRules Intl.RelativeTimeFormat Intl.Locale arguments".components(separatedBy: " ")
        
        let lamdaFunctions = "__ add addIndex adjust all allPass always and andThen any anyPass ap aperture append apply applySpec applyTo ascend assoc assocPath binary bind both call chain clamp clone comparator complement compose composeK composeP composeWith concat cond construct constructN contains converge countBy curry curryN dec defaultTo descend difference differenceWith dissoc dissocPath divide drop dropLast dropLastWhile dropRepeats dropRepeatsWith dropWhile either empty endsWith eqBy eqProps equals evolve F filter find findIndex findLast findLastIndex flatten flip forEach forEachObjIndexed fromPairs groupBy groupWith gt gte has hasIn hasPath head identical identity ifElse inc includes indexBy indexOf init innerJoin insert insertAll intersection intersperse into invert invertObj invoker is isEmpty isNil join juxt keys keysIn last lastIndexOf length lens lensIndex lensPath lensProp lift liftN lt lte map mapAccum mapAccumRight mapObjIndexed match mathMod max maxBy mean median memoizeWith merge mergeAll mergeDeepLeft mergeDeepRight mergeDeepWith mergeDeepWithKey mergeLeft mergeRight mergeWith mergeWithKey min minBy modulo move multiply nAry negate none not nth nthArg o objOf of omit once or otherwise over pair partial partialRight partition path pathEq pathOr paths pathSatisfies pick pickAll pickBy pipe pipeK pipeP pipeWith pluck prepend product project prop propEq propIs propOr props propSatisfies range reduce reduceBy reduced reduceRight reduceWhile reject remove repeat replace reverse scan sequence set slice sort sortBy sortWith split splitAt splitEvery splitWhen startsWith subtract sum symmetricDifference symmetricDifferenceWith T tail take takeLast takeLastWhile takeWhile tap test thunkify times toLower toPairs toPairsIn toString toUpper transduce transpose traverse trim tryCatch type unapply unary uncurryN unfold union unionWith uniq uniqBy uniqWith unless unnest until update useWith values valuesIn view when where whereEq without xor xprod zip zipObj zipWith".components(separatedBy: " ")
               
               generators.append(keywordGenerator(lamdaFunctions, tokenType: .identifier))
        
        generators.append(keywordGenerator(builtInObjectsIdentifiers, tokenType: .identifier))
        
        generators.append(keywordGenerator(keywords, tokenType: .keyword))
        
        // Line comment
        generators.append(regexGenerator("^//(.*)$", tokenType: .comment))
        
        // Block comment
        generators.append(regexGenerator("(/\\*)(.*)(\\*/)", options: [.dotMatchesLineSeparators], tokenType: .comment))
        
        // Single-line string literal
        generators.append(regexGenerator("(\"|@\")[^\"\\n]*(@\"|\")", tokenType: .string))
        
        // Multi-line string literal
        generators.append(regexGenerator("(\"\"\")(.*?)(\"\"\")", options: [.dotMatchesLineSeparators], tokenType: .string))

        // Editor placeholder
        var editorPlaceholderPattern = "(<#)[^\"\\n]*"
        editorPlaceholderPattern += "(#>)"
        generators.append(regexGenerator(editorPlaceholderPattern, tokenType: .editorPlaceholder))

        return generators.compactMap( { $0 })
    }()
    
    func generators(source: String) -> [TokenGenerator] {
        return generators
    }
}

extension SyntaxTextView {
#if os(macOS)
    var contentInset: NSEdgeInsets {
        set {
            contentTextView.textContainerInset = .init(width: newValue.left + newValue.right, height: newValue.top + newValue.bottom)
        }
        get {
            let hw = contentTextView.textContainerInset.width / 2
            let hh = contentTextView.textContainerInset.height / 2
            return .init(top: hh, left: hw, bottom: hh, right: hw)
        }
    }
#endif
    func adjustContentInset(_ insets: EdgeInsets) {
        contentInset = contentInset.adjusted(by: .top(20.0))
    #if os(iOS)
        contentTextView.scrollIndicatorInsets = .zero
    #endif
    }
}