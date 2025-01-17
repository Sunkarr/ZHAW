let doc1 = `Air quality in the sunny island improved gradually throughout Wednesday.`
let doc2 = `Air quality in Singapore on Wednesday continued to get worse as haze hit the island.`
let doc3 = `The air quality in Singapore is monitored through a network of air monitoring stations located in different parts of the island`
let doc4 = `The air quality in Singapore got worse on Wednesday.`

let stopwords = ['get','across','got','i','me','my','myself','we','our','ours','ourselves','you','your','yours','yourself','yourselves','he','him','his','himself','she','her','hers','herself','it','its','itself','they','them','their','theirs','themselves','what','which','who','whom','this','that','these','those','am','is','are','was','were','be','been','being','have','has','had','having','do','does','did','doing','a','an','the','and','but','if','or','because','as','until','while','of','at','by','for','with','about','against','between','into','through','during','before','after','above','below','to','from','up','down','in','out','on','off','over','under','again','further','then','once','here','there','when','where','why','how','all','any','both','each','few','more','most','other','some','such','no','nor','not','only','own','same','so','than','too','very','s','t','can','will','just','don','should','now']

function showTfidfTable(str1, str2, str3, str4) {

    let numDocs = 4
    let normaliseIdf = false

    // Convert documents to arrays
    var arr1 = str1.toLowerCase().trim().replace(/\n/g, " ").replace(/[\.,()]/g, "").replace(/  /g, " ").replace(/\?/g, "").replace(/\'/g, "_").split(" ")
    var arr2 = str2.toLowerCase().trim().replace(/\n/g, " ").replace(/[\.,()]/g, "").replace(/  /g, " ").replace(/\?/g, "").replace(/\'/g, "_").split(" ")
    var arr3 = str3.toLowerCase().trim().replace(/\n/g, " ").replace(/[\.,()]/g, "").replace(/  /g, " ").replace(/\?/g, "").replace(/\'/g, "_").split(" ")
    var arr4 = str4.toLowerCase().trim().replace(/\n/g, " ").replace(/[\.,()]/g, "").replace(/  /g, " ").replace(/\?/g, "").replace(/\'/g, "_").split(" ")

    // Get no. of words from each document
    var numWords1 = arr1.length
    var numWords2 = arr2.length
    var numWords3 = arr3.length
    var numWords4 = arr4.length
    
    // Get the vocabulary from each document
    var tokens1 = new Set(arr1)
    var tokens2 = new Set(arr2)
    var tokens3 = new Set(arr3)
    var tokens4 = new Set(arr4)
    var stopwordsSet = new Set(stopwords)
    var tokensAll = new Set([...tokens1, ...tokens2, ...tokens3, ...tokens4])
    var tokens = [...new Set(
        [...tokensAll].filter(x => !stopwordsSet.has(x)))];

    
    parse = (t) => tokens.map((w, i) => t.reduce((a, b) => b === w ? ++a : a, 0))
    var termCount1 = parse(arr1)
    var termCount2 = parse(arr2)
    var termCount3 = parse(arr3)
    var termCount4 = parse(arr4)

    delete arr1
    delete arr2
    delete arr3
    delete arr4

    countdf = (arr) => numDocs - arr.filter((el) => el === 0).length
    zip = (arr, ...arrs) => {
        return arr.map((val, i) => arrs.reduce((a, arr) => [...a, arr[i]], [val]));
    }
    var termCount = zip(termCount1, termCount2, termCount3, termCount4)

    var termFreq1 = termCount1.map(el => el/numWords1)
    var termFreq2 = termCount2.map(el => el/numWords2)
    var termFreq3 = termCount3.map(el => el/numWords3)
    var termFreq4 = termCount4.map(el => el/numWords4)
    var termFreq = zip(termFreq1, termFreq2, termFreq3, termFreq4)

    // Document-related
    var df = termCount.map((arr,i) => countdf(arr))
    var idf = termCount.map((arr,i) => Math.log10(numDocs/countdf(arr)))
    var sumIdf = normaliseIdf ? idf.reduce((a,b) => a+b,0) : 1
    var idfNorm = idf.map((el,i) => el/sumIdf)

    var tfidf1 = termFreq1.map((el,i) => el*idf[i])
    var tfidf2 = termFreq2.map((el,i) => el*idf[i])
    var tfidf3 = termFreq3.map((el,i) => el*idf[i])
    var tfidf4 = termFreq4.map((el,i) => el*idf[i])

    // Table header
    $('#tokenTable thead tr').remove();
    $("#tokenTable thead").append(`
        <tr>
            <th scope="col" rowspan="2" style="vertical-align: middle;">No.</th>
            <th scope="col" rowspan="2" style="vertical-align: middle;">Token</th>
            <th scope="col" colspan="4">Term count</th>
            <th scope="col" rowspan="2" style="vertical-align: middle;">Document count</th>
            <th scope="col" rowspan="2" style="vertical-align: middle;">IDF</th>
            <th scope="col" colspan="4">TF × IDF</th>
        </tr>
        <tr>
            <th scope="col">Doc 1</th>
            <th scope="col">Doc 2</th>
            <th scope="col">Doc 3</th>
            <th scope="col">Doc 4</th>
            <th scope="col">Doc 1</th>
            <th scope="col">Doc 2</th>
            <th scope="col">Doc 3</th>
            <th scope="col">Doc 4</th>
        </tr>`
    );

    // Tokens table
    for (var i = 0; i < tokens.length; i++) {
        var tableRow =
            `<tr>
                  <th scope="row">` + (i + 1) + `</th>
                  <td>` + tokens[i] + `</td>
                  <td>` + termFreq1[i] + `</td>
                  <td>` + termFreq2[i] + `</td>
                  <td>` + termFreq3[i] + `</td>
                  <td>` + termFreq4[i] + `</td>
                  <td>` + df[i] + `</td>
                  <td>` + Math.round(idfNorm[i] * 1000)/1000 + `</td>
                  <td>` + Math.round(tfidf1[i] * 1000)/1000 + `</td>
                  <td>` + Math.round(tfidf2[i] * 1000)/1000 + `</td>
                  <td>` + Math.round(tfidf3[i] * 1000)/1000 + `</td>
                  <td>` + Math.round(tfidf4[i] * 1000)/1000 + `</td>
            </tr>`
        $("#tokenTable tbody").append(tableRow)
    }

    // Sort normalised IDF
    indexedIdf = idfNorm.map((el,i) => {return {ind: i, val: el}});
    indexedIdf.sort((x, y) => {return x.val > y.val ? 1 : x.val == y.val ? 0 : -1}).reverse();
    // Get indices of the sorted array
    indicesSorted = indexedIdf.map((el) => el.ind);

    // Does not play well with Bootstrap's CSS
    // $('.form-control').highlightWithinTextarea({
    //     highlight: [
    //     {
    //         highlight: tokens[indicesSorted[0]],
    //         className: 'red'
    //     },
    //     {
    //         highlight: tokens[indicesSorted[1]],
    //         className: 'blue'
    //     },
    //     {
    //         highlight: tokens[indicesSorted[2]],
    //         className: 'yellow'
    //     }
    // ]});

    return
}

function prepare() {
    // Get data
    var textData = $("#textdata").val()
    var textData2 = $("#textdata2").val()
    var textData3 = $("#textdata3").val()
    var textData4 = $("#textdata4").val()

    // Clear tables
    $("#tokenTable tbody").empty()

    // Show tfidf table
    showTfidfTable(textData, textData2, textData3, textData4)
}

$(window).load(() => {

    $("#textdata").val(doc1)
    $("#textdata2").val(doc2)
    $("#textdata3").val(doc3)
    $("#textdata4").val(doc4)

    $("#prepareData").click(() => { prepare() });
});