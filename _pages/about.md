---
permalink: /
title: ""
author_profile: true
layout: single
redirect_from: 
  - /about
---

<!-- ========================================
     CSS 样式定义
     ======================================== -->
<style>
h1 {
  margin-bottom: 10px;  /* 标题下方间距 */
  margin-top: 50px;     /* 标题上方间距 */
}

h3 {
  margin-bottom: 5px;
  margin-left: 10px;  /* 标题左侧缩进 */
  font-size: 1.2em;   /* h3字体 => 原来的 1.2 倍 */ /* em - 相对长度单位 */
}

h4 {
  margin-bottom: 5px;
  margin-left: 20px;
  font-size: 1.1em;   
  color: #666666;     /* h4颜色稍淡，介于h3和正文之间 */
}

h1:first-of-type {
  margin-top: 0;
}


.content-block {
  margin-bottom: 30px;
}

.indented-content {
  margin-left: 30px;
  line-height: 1.8;
}

.bullet-point {
  margin-left: 20px;
  margin-top: 2px;
  margin-bottom: 12px;
  position: relative;
}

.bullet-point::before {
  content: "•";
  position: absolute;
  left: -15px;
  color: #666;
  font-weight: bold;
}

.bullet-point-sub {
  margin-left: 40px;
  margin-top: 2px;
  margin-bottom: 10px;
  position: relative;
}

.bullet-point-sub::before {
  content: "▸";  /* 可以选择：▸ ▹ ▶ ▷ ➤ ➜ ➝ ➞ ➟ ➠ ➡ ➢ ➣ ➤ ➥ ➦ ➧ ➨ ➩ ➪ ➫ ➬ ➭ ➮ ➯ ➱ ➲ ➳ ➴ ➵ ➶ ➷ ➸ ➹ ➺ ➻ ➼ ➽ ➾ ➿ */
  position: absolute;
  left: -15px;
  color: #666;
  font-weight: normal;
}

.annotate {
  float: right;
  font-weight: normal;  /* 时间不加粗 */
  font-size: 1rem;      /* 时间使用根元素字体大小，不随h标签变化 */
}
</style>

<!-- ==================== 学习经历 ==================== -->
<h1>学习经历</h1>

<!-- ========== 上海交通大学 ========== -->
<div class="content-block">
  <h3><strong>上海交通大学</strong> - 网络空间安全  <span class="annotate">2021.09 - 2024.03</span> </h3>
  <div class="indented-content">
    GPA：3.76/4.0
  </div>
</div>

<!-- ========== 吉林大学 ========== -->
<div class="content-block">
  <h3><strong>吉林大学</strong> - 通信工程  <span class="annotate">2017.09 - 2021.07</span> </h3>
  <div class="indented-content">
    GPA：3.83/4.0<br>
    年级排名：3/309（前 1%）<br>
    荣誉：国家奖学金（2次），校优秀毕业生
  </div>
</div>

<!-- ==================== 工作经历 ==================== -->
<h1>工作经历</h1>

<!-- ========== 腾讯 ========== -->
<div class="content-block">
  <h3><strong>腾讯</strong> - 异构计算研发工程师（大模型推理加速方向）  <span class="annotate">2024.05 - 至今</span> </h3>
  </div>
<div class="content-block">
  <h3><strong>阿里云</strong> - 基础平台研发实习生  <span class="annotate">2023.06 - 2023.09</span> </h3>
</div>

<!-- ==================== 项目 ==================== -->
<h1>主要项目</h1>
<div class="content-block">
  <!-- <h3><strong>与 NVIDIA 合作开源了 kv cache offloading 框架：<a href="https://github.com/taco-project/FlexKV" target="_blank" rel="noopener noreferrer">FlexKV</a></strong></h3> -->
  <h3><strong>与 NVIDIA 合作开源了 kv cache offloading 框架：FlexKV</a></strong></h3>
  <div class="indented-content">
    背景：<br>
    <div class="bullet-point">
      LLM 推理服务通常都会采用 Prefix Cache 技术，来重用已经计算过的 kv cache，从而优化推理性能。
      而受限于 GPU 显存，当前并不能保存很多请求的 kv cache。
    </div>
    <div class="bullet-point">
      该框架便是解决上述提到的问题，它可以将"冷"kv cache 卸载到 cpu、ssd，甚至远端，
      从而可以索引和管理多级 kv cache，并复用，通过复用这些 kv cache 来提升 LLM 推理的性能。
    </div>
    <p>工作介绍：参与了 FlexKV 框架的开发及与内部框架适配、开源框架适配的工作。</p>
  </div>
</div>

<div class="content-block">
  <h3><strong>内部推理框架 TACO-LLM 上 PD 分离特性的开发</strong></h3>
  <div class="indented-content">
    背景：<br>
    <div class="bullet-point">
      DeepSeek 需求爆发后，因为其 DeepSeek 模型适合大规模部署，且 Prefill 和 Decode 任务的计算特点不同，
      因此，它适合结合 PD 分离来做大规模部署。
    </div>
    工作介绍：<br>
    <div class="bullet-point">
      调研相关论文和社区实现后，主导设计和开发了内部推理框架的 PD 分离能力使得该框架具备了 PD 分离的能力，
      并与 MTP、prefix cache、chunked prefill 等特性相结合，最终上线了内部的 MaaS 平台。
    </div>
    <div class="bullet-point">
      值得一提的是，该方案早于开源地支持了 1）XPYD 任意数量建联；2）P、D 节点动态扩缩容；3）P、D 节点支持异构并行模式等能力。
    </div>
  </div>
</div>

<!-- <div class="content-block">
  <h3><strong>内部推理框架 TACO-LLM 上性能优化</strong></h3>
  <div class="indented-content">
    背景：<br>
    <div class="bullet-point">
      TACO-LLM 是一款类似于 vLLM, SGLang 的推理框架，它的性能领先于开源框架。
    </div>
    工作介绍：<br>
    <div class="bullet-point">
      调研相关论文和社区实现后，主导设计和开发了内部推理框架的 PD 分离能力使得该框架具备了 PD 分离的能力，
      并与 MTP、prefix cache、chunked prefill 等特性相结合，最终上线了内部的 MaaS 平台。
    </div>
    <div class="bullet-point">
      值得一提的是，该方案早于开源地支持了 1）XPYD 任意数量建联；2）P、D 节点动态扩缩容；3）P、D 节点支持异构并行模式等能力。
    </div>
  </div>
</div> -->

<div class="content-block">
  <h3><strong>CPU 辅助的异构投机采样</strong></h3>
  <div class="indented-content">
    背景：<br>
    <div class="bullet-point">
      GPU 价格昂贵导致推理成本高昂，我们尝试探索 CPU 在 LLM 推理中的可行性。
    </div>
    工作介绍：<br>
    <div class="bullet-point">
      探索 CPU 在 LLM 推理中的可行性，尝试将 CPU 用于大小模型投机采样的小模型部分，从而降低总的推理成本。
    </div>
    <div class="bullet-point">
      创新性地设计了全异步投机采样推理方式，将 CPU 上小模型生成 draft token 和 GPU 上大模型进行验证的串行操作完全异步起来，进一步减少 CPU 的资源浪费。
    </div>
  </div>
</div>

<!-- ========================================
     专业技能
     ======================================== -->
<!-- ==================== 1级标题 ==================== -->
<h1>专业技能</h1>
<div class="content-block">
  <div class="indented-content">
    <div class="bullet-point">
      熟悉主流 LLM 推理框架：vLLM, SGLang, trtllm...
    </div>
    <div class="bullet-point">
      熟悉 LLM 框架相关的优化：continous batching, paged attention, prefix cache, chunked prefill...
    </div>
    <div class="bullet-point">
      熟悉分布式推理优化：TP, PP, EP, DP...
    </div>
    <div class="bullet-point">
      熟悉 PD 分离
    </div>
    <div class="bullet-point">
      熟悉投机采样：speculative samping, lookahead, medusa, MTP...
    </div>
    <div class="bullet-point">
      熟悉 GPU 体系结构及 kernel 性能分析：nsys, ncu, torch profiler...
    </div>
  </div>
</div>