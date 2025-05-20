/* generated using openapi-typescript-codegen -- do not edit */
/* istanbul ignore file */
/* tslint:disable */
/* eslint-disable */
import type { BaseResponse_CodeVo_ } from '../models/BaseResponse_CodeVo_';
import type { BaseResponse_QuestionSubmitVo_ } from '../models/BaseResponse_QuestionSubmitVo_';
import type { QuestionSubmitAddRequest } from '../models/QuestionSubmitAddRequest';
import type { CancelablePromise } from '../core/CancelablePromise';
import { OpenAPI } from '../core/OpenAPI';
import { request as __request } from '../core/request';
export class QuestionSubmitControllerService {
    /**
     * doQuestionSubmit
     * @param questionSubmitAddRequest questionSubmitAddRequest
     * @returns BaseResponse_QuestionSubmitVo_ OK
     * @returns any Created
     * @throws ApiError
     */
    public static doQuestionSubmitUsingPost(
        questionSubmitAddRequest: QuestionSubmitAddRequest,
    ): CancelablePromise<BaseResponse_QuestionSubmitVo_ | any> {
        return __request(OpenAPI, {
            method: 'POST',
            url: '/api/question/submit/',
            body: questionSubmitAddRequest,
            errors: {
                401: `Unauthorized`,
                403: `Forbidden`,
                404: `Not Found`,
            },
        });
    }
    /**
     * getCode
     * @param questionId questionId
     * @returns BaseResponse_CodeVo_ OK
     * @throws ApiError
     */
    public static getCodeUsingGet(
        questionId: number,
    ): CancelablePromise<BaseResponse_CodeVo_> {
        return __request(OpenAPI, {
            method: 'GET',
            url: '/api/question/submit/getCode',
            query: {
                'questionId': questionId,
            },
            errors: {
                401: `Unauthorized`,
                403: `Forbidden`,
                404: `Not Found`,
            },
        });
    }
}
