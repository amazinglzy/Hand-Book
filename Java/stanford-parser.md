# Stanford Parser 记录

**测试数据**
当 希拉里 还 是 个 孩子 的 时候，她 就是 公立学校 老师们 眼中 的 红人。她 参加 游泳、垒球 和 其它 体育 项目，获得 了 许多 奖项。母亲 多萝西 对 希拉里 给予 了 很高的 期望，她 常 敦促 希拉里 为 自己 制定 远大的 目标，并 建议 她 尝试 成为 美国 第一位 最高 法院 女 法官。不过，希拉里 更 希望 自己 成为 一名 宇航员，14岁 时 她 给 美国 航空航天局 写 信 主动 请缨，结果 被 对方 告知 不 需要 女 宇航员。

1. 使用 stanford parser 将中文解析成短语结构语法树（完全句法分析）

    ```java
    import edu.stanford.nlp.parser.lexparser.LexicalizedParser;
    import edu.stanford.nlp.trees.Tree;
    
    public class Main {
        private static final String basedir = System.getProperty("SegDemo", "data");

        public static void main(String[] args) throws Exception {
            String grammar = "edu/stanford/nlp/models/lexparser/chinesePCFG.ser.gz";
            String[] options = {};
            LexicalizedParser lp = LexicalizedParser.loadModel(grammar, options);
            String line = "我 的 名字 叫 小明 ？";
            Tree parse = lp.parse(line);
            parse.pennPrint();
        }
    }
    ```

2. 中文 Segment（分词）+ 完全句法分析

    ```java
    import java.util.List;
    import java.util.Properties;
    import java.util.Scanner;

    import edu.stanford.nlp.ie.crf.CRFClassifier;
    import edu.stanford.nlp.ling.CoreLabel;

    import edu.stanford.nlp.parser.lexparser.LexicalizedParser;
    import edu.stanford.nlp.trees.Tree;
    import edu.stanford.nlp.ling.Word;

    public class Main {

        private static final String basedir = System.getProperty("Test_Seg", "data");
        static Scanner scan = new Scanner(System.in);

        public static void main(String[] args) {
        // write your code here
            String grammar = "edu/stanford/nlp/models/lexparser/chinesePCFG.ser.gz";
            String[] options = {};
            LexicalizedParser lp = LexicalizedParser.loadModel(grammar, options);
            String line = "我 的 名字 叫 小明 ？";
            Tree parse = lp.parse(line);
            parse.pennPrint();

    //        String[] arg2 = { "-encoding", "utf-8", "-outputFormat",
    //                "penn,typedDependenciesCollapsed",
    //                "edu/stanford/nlp/models/lexparser/chinesePCFG.ser.gz",
    //                "-"};
    //        LexicalizedParser.main(arg2);

    //        System.setOut(new PrintStream(System.out, true, "utf-8"));

            Properties props = new Properties();
            props.setProperty("sighanCorporaDict", basedir);
            props.setProperty("NormalizationTable", "data/norm.simp.utf8");
            props.setProperty("normTableEncoding", "UTF-8");
            // below is needed because CTBSegDocumentIteratorFactory accesses it
            props.setProperty("serDictionary", basedir + "/dict-chris6.ser.gz");
    //        if (args.length > 0) {
    //            props.setProperty("testFile", args[0]);
    //        }
            props.setProperty("inputEncoding", "UTF-8");
            props.setProperty("sighanPostProcessing", "true");

            CRFClassifier<CoreLabel> segmenter = new CRFClassifier<>(props);
            segmenter.loadClassifierNoExceptions(basedir + "/ctb.gz", props);
    //        for (String filename : args) {
    //            segmenter.classifyAndWriteAnswers(filename);
    //        }

            String sample = "我住在美国。";
            List<String> segmented = segmenter.segmentString(sample);
            System.out.println(segmented);
            while (true) {
                sample = scan.nextLine();
                segmented = segmenter.segmentString(sample);
                System.out.println(segmented);

                line = "";
                for (String token : segmented) {
                    line += token + ' ';
                }
                parse = lp.parse(line);
                parse.pennPrint();
            }

        }
    }
    ```

3. 使用 stanford corenlp 中的 annotate 进行 指代消解

    ```java
    import java.util.Properties;
    import java.util.Scanner;

    import edu.stanford.nlp.coref.CorefCoreAnnotations;
    import edu.stanford.nlp.coref.data.CorefChain;
    import edu.stanford.nlp.coref.data.Mention;
    import edu.stanford.nlp.ling.CoreAnnotation;
    import edu.stanford.nlp.ling.CoreAnnotations;
    import edu.stanford.nlp.pipeline.Annotation;
    import edu.stanford.nlp.pipeline.StanfordCoreNLP;
    import edu.stanford.nlp.util.CoreMap;

    public class Main {
        private static Scanner scan = new Scanner(System.in);

        public static void main(String[] args) {
        // write your code here
    //        Annotation document = new Annotation("Barack Obama was born in Hawaii.  He is the president. Obama was elected in 2008.");
            Annotation document = new Annotation("今天温度是19度，它让人感到很舒服。");
            Properties props = new Properties();
    //        props.setProperty("annotators", "tokenize,ssplit,pos,lemma,ner,parse,coref");
            props.setProperty("annotators", "tokenize, ssplit, pos, lemma, ner, parse, coref");
            props.setProperty("coref.algorithm", "hybrid");
            props.setProperty("coref.language", "zh");
            props.setProperty("coref.sieves", "ChineseHeadMatch, ExactStringMatch, PreciseConstructs, StrictHeadMatch1, StrictHeadMatch2, StrictHeadMatch3, StrictHeadMatch4, PronounMatch");
            props.setProperty("coref.postprocessing", "true");
            props.setProperty("coref.zh.dict", "edu/stanford/nlp/models/dcoref/zh-attributes.txt.gz");
            props.setProperty("pos.model", "edu/stanford/nlp/models/pos-tagger/chinese-distsim/chinese-distsim.tagger");
            props.setProperty("parse.model", "edu/stanford/nlp/models/srparser/chineseSR.ser.gz");

            StanfordCoreNLP pipeline = new StanfordCoreNLP(props);

            while (true) {
                String input_text = scan.nextLine();
                Annotation doc = new Annotation(input_text);
                pipeline.annotate(doc);
                System.out.println("---");
                System.out.println("coref chains");

                for (CorefChain cc : doc.get(CorefCoreAnnotations.CorefChainAnnotation.class).values()) {
                    System.out.println("\t" + cc);
                }
                for (CoreMap sentence : doc.get(CoreAnnotations.SentencesAnnotation.class)) {
                    System.out.println("---");
                    System.out.println("mentions");
                    for (Mention m : sentence.get(CorefCoreAnnotations.CorefMentionsAnnotation.class)) {
                        System.out.println("\t" + m);
                    }
                }
            }
        }
    }
    ```

    一些类的说明：
    class edu.stanford.nlp.ling.CoreAnnotations.TextAnnotation
    + `toString()` 返回这句话原文本。

    class edu.stanford.nlp.ling.CoreAnnotations.TokensAnnotation, 
    + `toString()` 返回这句话的 tokens 以其标号。
    class edu.stanford.nlp.ling.CoreAnnotations.SentencesAnnotation, 
    + `toString()` 字符串化一个列表，列表的元素为一个句子。
    class edu.stanford.nlp.ling.CoreAnnotations.MentionsAnnotation, 
    + `toString()` 一个列表，列表的每个元素包含代词。

        class edu.stanford.nlp.ling.CoreAnnotations.TextAnnotation, 
        class edu.stanford.nlp.ling.CoreAnnotations.CharacterOffsetBeginAnnotation, 
        class edu.stanford.nlp.ling.CoreAnnotations.CharacterOffsetEndAnnotation, 
        + 在原文本中的位置
        class edu.stanford.nlp.ling.CoreAnnotations.TokensAnnotation, 
        + 对应 token 内容及标号
        class edu.stanford.nlp.ling.CoreAnnotations.TokenBeginAnnotation, 
        class edu.stanford.nlp.ling.CoreAnnotations.TokenEndAnnotation, 
        class edu.stanford.nlp.ling.CoreAnnotations.SentenceIndexAnnotation, 
        + 对应的句子
        class edu.stanford.nlp.ling.CoreAnnotations.NamedEntityTagAnnotation, 
        + 命名实体
        class edu.stanford.nlp.ling.CoreAnnotations.EntityTypeAnnotation, 
        class edu.stanford.nlp.ling.CoreAnnotations.EntityMentionIndexAnnotation, 
        class edu.stanford.nlp.ling.CoreAnnotations.CanonicalEntityMentionIndexAnnotation

    class edu.stanford.nlp.coref.CorefCoreAnnotations.CorefMentionsAnnotation, 
    + `toString()` 上述 `Mention` 相关的短语；
    + 元素类型为 `Mention` 的列表。

    class edu.stanford.nlp.ling.CoreAnnotations.CorefMentionToEntityMentionMappingAnnotation, 
    + 上述 CorefMention 与 Mention 的对应关系。

    class edu.stanford.nlp.ling.CoreAnnotations.EntityMentionToCorefMentionMappingAnnotation, 
    + 类似上一条。

    class edu.stanford.nlp.coref.CorefCoreAnnotations.CorefChainAnnotation
    + 指代关系链。

4. 使用 stanford corenlp 中的 simple api

    **出现的问题**
    1. NoClassDefFoundError

        没有将 `protobuf.jar` 加入 `classpath`。