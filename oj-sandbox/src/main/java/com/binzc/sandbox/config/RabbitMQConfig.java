package com.binzc.sandbox.config;


import org.springframework.amqp.core.Binding;
import org.springframework.amqp.core.BindingBuilder;
import org.springframework.amqp.core.DirectExchange;
import org.springframework.amqp.core.Queue;
import org.springframework.amqp.support.converter.Jackson2JsonMessageConverter;
import org.springframework.amqp.support.converter.MessageConverter;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

@Configuration
public class RabbitMQConfig {

    // 1. 定义交换机（direct 类型）
    @Bean
    public DirectExchange judgeExchange() {
        return new DirectExchange("judge_exchange");
    }

    // 2. 定义任务队列
    @Bean
    public Queue judgeTaskQueue() {
        return new Queue("judge_task_queue");
    }

    // 3. 将交换机和任务队列绑定
    @Bean
    public Binding judgeTaskBinding(Queue judgeTaskQueue, DirectExchange judgeExchange) {
        return BindingBuilder.bind(judgeTaskQueue).to(judgeExchange).with("judge_task");
    }


    @Bean
    public Queue judgeResultQueue() {
        return new Queue("judge_result_queue");
    }

    @Bean
    public Binding judgeResultBinding(Queue judgeResultQueue, DirectExchange judgeExchange) {
        return BindingBuilder.bind(judgeResultQueue).to(judgeExchange).with("judge_result");
    }


    // 4. 启用 JSON 消息格式
    @Bean
    public MessageConverter messageConverter() {
        return new Jackson2JsonMessageConverter();
    }
}
