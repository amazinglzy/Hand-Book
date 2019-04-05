在 es 的一次查询中，打分主要包括两部分，第一部分是 `query_weight`，另一部分是 `field_weight`，最后打分的结果就是 `query_weight * field_weight`，而 `query_weight = idf * queryNorm(d)`，`idf` 是指在一个分片中，包含某个 `term` 的文档数 除以 所有的文档数，而 `queryNorm(d)` 是 `sqrt(sum(idf_i*idf_i))` ，对于查询中所有的 `term` 都计算一次 `idf`，然后求和并开根号。

以上是对于查询和所有文档的一个打分，这个对于排序影响是不大的，因为所有的文档得分都包括这个。

而对于 `field_weight` 来说，`field_weight = idf*tf*fieldnorm`，`tf` 是指 `term` 在文档中出现的次数开根号，
而 `fieldnorm` 是：
> 从网上其他资料中了解到fieldnorm应该就是指的
> norm(t,d)=d.getBoost()*lengthNorm(field)*f.getBoost()
> lucene中getBoost默认都是1,所以关键是lengthNorm(field)，它的计算是1/sqrt(numTerms)，而numTerms是文档的字符长度，这样计算的结果和explain有差异，是因为lucene的存储方式做了编码，丢失了精度。
> 例：
> 一个field的term数量为7，lengthNorm的精确值为：0.37796447
> 将该数值的二进制值为：0.01100000110000100100011110001101
> 保留三位有效数字后为：0.0110
> 这样实际存储的值为：0.0110=0.375
> Lucene采用这样的方式存储的优点是节省了存储空间，缺点就是精度丢失
